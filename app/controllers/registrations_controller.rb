class RegistrationsController < Devise::RegistrationsController
    
skip_before_action :authenticate_organization!, :only => [:new, :create, :cancel]

def create

    organization_params = sign_up_params_organization
    user_params = sign_up_params_user

    prep_signup_view(organization_params, user_params)
  
    Organization.transaction do
        @organization.save
        if @organization.errors.empty? #organization created
            if @organization.plan == 'premium'
                @payment = Payment.new({email: user_params["email"],
                    token: params[:payment]["token"],
                    organization: @organization})
                flash[:error] = "Please review your payment information." unless @payment.valid?   
            
                begin
                    @payment.process_payment
                    @payment.save
                rescue Exception => e
                    flash[:error] = e.message
                    @organization.destroy
                    log_action("Payment failed")
                    render :new and return
                end
            end
        else
            resource.valid?
            log_action("organization creation failed.", @organization)
            render :new
        end

        if flash[:error].blank? || flash[:error].empty? #payment successful

            initiate_organization (@organization)

            devise_create(user_params) #devise resource (user) creation

            if resource.errors.empty? #SUCCESS!

                log_action ("signup user/organization success," resource)

                organization.organization_signup(resource, @organization, coupon_params)

            else
                log_action("Signup user failed.", resource)
                raise ActiveRecord::Rollback
            end
        else
            resource.valid?
            log_action("Payment processing failed.", @organization)
            render :new and return
        end
    end

    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up, keys: [:email, :password, :confirm_password, organization_attibutes: [:plan]]
    end

    def sign_up_params_organization
        params.require(:organizations).permit(:name, :subdomain, :domain, :plan)
    end
    def sign_up_params_user
        params.permit(:user)
    end

end