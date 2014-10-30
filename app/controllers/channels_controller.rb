class ChannelsController < ApplicationController
  before_action :set_channel, only: [:edit, :update, :destroy, :toggle_muted, :unsubscribe, :subscribe_users]
  before_action :authorize, only: [:edit, :update, :destroy]
  decorates_assigned :channels
    
  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.visible_for(current_user).order(last_message_at: :desc, created_at: :desc).page(params[:page])
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)
    @channel.users << current_user unless @channel.users.include?(current_user) or @channel.public?

    respond_to do |format|
      if @channel.save
        format.html { redirect_to channel_messages_path(@channel), notice: 'Chat erfolgreich erstellt.' }
        format.json { render action: 'show', status: :created, location: @channel }
      else
        format.html { render action: 'new' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to channel_messages_path(@channel), notice: 'Chat erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /channels/1/subscribe_users
  # POST /channels/1/subscribe_users.json
  def subscribe_users
    @channel.users << User.where(id: params[:channel][:user_ids])

    respond_to do |format|
      if @channel.save
        format.html { redirect_to channel_messages_path(@channel), notice: 'Abonnenten erfolgreich hinzugefuegt.' }
        format.json { render action: 'show', status: :created, location: @channel }
      else
        format.html { render action: 'show', location: @channel }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATH/PUT /channels/1/toggle_muted
  # PATH/PUT /channels/1/toggle_muted.json
  def toggle_muted
    @channel.toggle_muted_for current_user
    respond_to do |format|
      format.html { redirect_to channel_messages_path(@channel), notice: "Chat ist jetzt #{@channel.muted_by?(current_user) ? "nicht mehr " : ""}stumgeschaltet." }
      format.json { head :no_content }
    end
  end

  # PATH/PUT /channels/1/unsubscribe
  # PATH/PUT /channels/1/unsubscribe.json
  def unsubscribe
    @channel.unsubscribe current_user
    respond_to do |format|
      format.html { redirect_to channels_path, notice: "Abonnement erfolgreich beendet." }
      format.json { head :no_content }
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.friendly.find(params[:id])
    end

    def authorize
      unauthorized_access channels_url unless @channel.visible_for? current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:title, :public, :user_ids => [])
    end
end
