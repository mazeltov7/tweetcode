  #coding: utf-8

class BeginnerMessagesController < ApplicationController

  include ActionController::Live

  def index
    @beginner_messages = BeginnerMessage.all.order("created_at DESC")

   
  end

  def create  
    response.headers["Content-Type"] = "text/javascript"
    @beginner_message = BeginnerMessage.create!(attributes)
    @beginner_message.user = current_user
    @beginner_message.save

    json_message = @beginner_message.to_json
    hash_result = JSON.parse(json_message)
    hash_result[:username] = @beginner_message.user.username
    hash_result[:created_at] = @beginner_message.created_at.strftime("%H:%M")
    hash_result[:status] = @beginner_message.user.status
    @json_result = hash_result.to_json
    $redis.publish('beginner_messages.create', @json_result)
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('beginner_messages.*') do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end


  private

  def attributes
    params.require(:beginner_message).permit(:body, :created_at)
  end

  

end