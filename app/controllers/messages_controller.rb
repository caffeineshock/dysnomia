class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_channel
  before_action :authorize_moderator, only: [:destroy, :destroy_all]
  decorates_assigned :channel, :messages

  # GET /messages
  # GET /messages.json
  def index
    @channel.users << current_user unless @channel.users.include? current_user
    @messages = Message.where(channel: @channel).order(created_at: :desc).page(params[:page]).per_page(30)
    @possible_subscribers = User.not_subscribed_to @channel
    @channel.mark_messages_read_for current_user

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params).tap do |m|
      m.user = current_user
      m.channel = @channel
    end

    if @message.save
      push_notification :add
      @message.mark_as_read! for: current_user
    end

    render inline: "{}"
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    push_notification :remove
    @message.destroy
    respond_to do |format|
      format.html { redirect_to channel_messages_url(@channel) }
      format.json { head :no_content }
    end
  end

  # DELETE /messages
  # DELETE /messages.json
  def destroy_all
    Message.destroy_all(channel: @channel)
    respond_to do |format|
      format.html { redirect_to channel_messages_url(@channel), notice: 'Chat erfolgreich geleert.' }
      format.json { head :no_content }
    end
  end

  # PUT /messages
  # PUT /messages.json
  def mark_all_read
    @channel.mark_messages_read_for current_user
    respond_to do |format|
      format.html { redirect_to channel_messages_url(@channel), notice: 'Nachrichten als gelesen markiert.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def set_channel
      @channel = Channel.friendly.find(params[:channel_id])
      unauthorized_access channels_url unless @channel.visible_for? current_user
    end

    def push_notification type
      PrivatePub.publish_to '/unread', {
        type: type.to_s,
        source: current_user.id,
        model: "message",
        channel: @channel.id,
        message: @message.id
      }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body)
    end
end
