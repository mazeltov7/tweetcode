#coding: utf-8

class BeginnerMessagesController < ApplicationController
  before_action :authenticate_user!

  include ActionController::Live

  def index
    @beginner_messages = BeginnerMessage.all
  end

  def create  
    response.headers["Content-Type"] = "text/javascript"
    attributes = params.require(:beginner_message).permit(:body)
    @beginner_message = BeginnerMessage.create(attributes)
    $redis.publish('beginner_messages.create', @beginner_message.to_json)
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
  
end