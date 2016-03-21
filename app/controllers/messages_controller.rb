class MessagesController < ApplicationController
  before_action :user_logged_in

  def index
    if params[:action_mess] == 'sent'
      @messages = current_user.sent_messages
    elsif params[:action_mess] == 'incoming'
      @messages = current_user.incoming_messages 
    else
      @messages = Message.all
    end
  end

  def new
  	@message = Message.new 
  end

  def show
    @message = Message.find_by_id(params[:id])
    if @message.recipient_id == current_user.id
      @message.read_at = Time.now 
      @message.save
    end
  end

  def create
      recipient = User.find(params[:message][:recipient_id])
      @message = Message.create(sender_id: current_user.id, recipient_id: recipient.id, body: params[:message][:body], title: params[:message][:title], read_at: nil)
      if @message.save
        flash[:success] ='Message sent successfully.'
        redirect_to user_messages_path(current_user,action_mess: 'sent')
      else
        flash[:error] ='Message fail please check again.'
        render "new"
      end
  end

  private

end
