class RelatedFilesController < ApplicationController
  before_action :set_related_file, only: %i[ show edit update destroy ]

  # GET /related_files or /related_files.json
  def index
    @related_files = RelatedFile.all
  end

  # GET /related_files/1 or /related_files/1.json
  def show
  end

  # GET /related_files/new
  def new
    @related_file = RelatedFile.new
  end

  # GET /related_files/1/edit
  def edit
  end

  # POST /related_files or /related_files.json
  def create
    @related_file = RelatedFile.new(related_file_params)

    respond_to do |format|
      if @related_file.save
        format.html { redirect_to @related_file, notice: "Related file was successfully created." }
        format.json { render :show, status: :created, location: @related_file }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @related_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /related_files/1 or /related_files/1.json
  def update
    respond_to do |format|
      if @related_file.update(related_file_params)
        format.html { redirect_to @related_file, notice: "Related file was successfully updated." }
        format.json { render :show, status: :ok, location: @related_file }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @related_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /related_files/1 or /related_files/1.json
  def destroy
    @related_file.destroy
    respond_to do |format|
      format.html { redirect_to related_files_url, notice: "Related file was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_related_file
      @related_file = RelatedFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def related_file_params
      params.require(:related_file).permit(:name, :task_id)
    end
end
