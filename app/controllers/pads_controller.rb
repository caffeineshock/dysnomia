class PadsController < ApplicationController
  include CrudListeners
  before_action :set_pad, only: [:show, :edit, :update, :destroy]
  decorates_assigned :pad

  # GET /pads
  # GET /pads.json
  def index
    @pads = Pad.order(updated_at: :desc).page(params[:page])
    Pad.mark_as_read! @pads.to_a, :for => current_user
  end

  # GET /pads/1
  # GET /pads/1.json
  def show
  end

  # GET /pads/new
  def new
    @pad = Pad.new
  end

  # GET /pads/1/edit
  def edit
  end

  # POST /pads
  # POST /pads.json
  def create
    @pad = etherpad_service.create pad_params[:title]

    respond_to do |format|
      format.html { redirect_to @pad, notice: 'Pad erfolgreich erstellt.' }
      format.json { render action: 'show', status: :created, location: @pad }
    end
  end

  # PATCH/PUT /pads/1
  # PATCH/PUT /pads/1.json
  def update
    respond_to do |format|
      if @pad.update(pad_params)
        format.html { redirect_to @pad, notice: 'Pad erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pads/1
  # DELETE /pads/1.json
  def destroy
    @pad.destroy
    respond_to do |format|
      format.html { redirect_to pads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pad
      @pad = Pad.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pad_params
      params.require(:pad).permit(:title)
    end

    def etherpad_service
      @etherpad_service ||= EtherpadService.new(
        url: Settings.etherpad_address,
        version: Settings.etherpad_api_version,
        api_key: Rails.application.secrets.etherpad_api_key
      )
    end
end
