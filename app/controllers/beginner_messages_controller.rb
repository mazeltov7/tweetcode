class BeginnerMessagesController < ApplicationController
  before_filter :authenticate_user!

  include ActionController::Live

  def index
    @messages = BeginnerMessage.all
  end

  def create
    attributes = params.require(:beginner_message).permit(:body)
    @message = BeginnerMessage.create!(attributes)
  end

  def event
  end
  
end