  #coding: utf-8

class BeginnerMessagesController < ApplicationController


  def index
    @beginner_messages = BeginnerMessage.all.order("created_at DESC")
    puts @beginner_messages.inspect
   
  end

  def create  
    response.headers["Content-Type"] = "text/javascript"
    @beginner_message = BeginnerMessage.create(attributes)
    @beginner_message.user = current_user
    @beginner_message.created_at = Time.now
    @beginner_message.save
    puts "22"
    puts @beginner_message.created_at
    puts "3"

    @beginner_messages = BeginnerMessage.all
    puts @beginner_messages.last.inspect

  end


  private

  def attributes
    params.require(:beginner_message).permit(:body, :created_at)
  end
  

end