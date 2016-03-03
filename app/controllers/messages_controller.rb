class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :destroy]

  def index
    @messages = Message.all
    render json: @messages
  end

  def show
    @message = Message.find(params[:id])
    render json: @message
  end

  def new
  end

  def create
    @message = Message.new(message_params)
    ContactForm.contact(@message).deliver_now
    if @message.save
      render json: @message
    else
      render json: @message.errors
    end
  end


  def destroy
    @message = Message.find(params[:id])
    @message.destroy
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :message)
  end
end
