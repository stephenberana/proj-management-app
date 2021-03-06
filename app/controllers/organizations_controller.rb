class OrganizationsController < ApplicationController
  protect_from_forgery prepend: true, with: :null_session
  before_action :set_organization, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[create new home]
  # before_action :require_admin, except: %i[create new]



  # GET /organizations or /organizations.json
  def home

  end
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1 or /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations or /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to  new_admin_registration_url(subdomain: @organization.subdomain), notice: "Organization was successfully created." }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1 or /organizations/1.json
  def update
    respond_to do |format|
      Organization.transaction do
        if @organization.update(organization_params)
          if @organization.plan == "premium" && @organization.payment.blank?
            @payment = Payment.new({email: organization_params["email"],
                                    token: params[:payment]["token"],
                                    organization: @organization})
            begin
              @payment.process_payment
              @payment.save
            rescue Exception => e
              flash[:error] = e.message
              @payment.destroy
              @organization.plan = "free"
              @organization.save
              
              redirect_to edit_organization_path(@organization) and return
            end
          end
          format.html { redirect_to @organization, notice: "Organization was successfully updated." }
          format.json { render :show, status: :ok, location: @organization }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /organizations/1 or /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: "Organization was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @organization = Organization.check_db(params[:organization])
    if @organization
      @organization
    else
      flash[:alert] = "Organization doesn't exists."
    end
    render 'organizations/home'
  end

  def change
    @organization = Organization.find(params[:id])
    Organization.set_current_organization @organization.id
    session[:organization_id] = Organization.current_organization.id
    redirect_to home_index_path, notice: "Switched to organization: #{organization.name}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.require(:organization).permit(:name, :subdomain, :domain, :plan)
    end

    def require_admin
      return if current_user.type == "Admin"
      flash[:alert] = 'Access denied'
      redirect_to dashboard_path
    end
end
