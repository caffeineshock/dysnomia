class UploadsController < ApplicationController
  include CrudListeners
  before_action :set_instance, only: [:show, :edit, :update, :destroy]
  decorates_assigned :upload, :uploads

  # GET /uploads
  # GET /uploads.json
  def index
    if params[:search]
      @search = Upload.search { fulltext params[:search] }
      @uploads = Upload.where(id: @search.results.map(&:id)).page(params[:page])
    else
      @uploads = Upload.order(updated_at: :desc).page(params[:page])
    end

    Upload.mark_as_read! @uploads.to_a, :for => current_user
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)

    respond_to do |format|
      if @upload.save
        format.html { redirect_to uploads_url, notice: 'Datei erfolgreich hochgeladen.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to upload_url(@upload), notice: 'Datei aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_instance
    @upload = Upload.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def upload_params
    params.require(:upload).permit(:note, :file)
  end
end
