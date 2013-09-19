class BeginnerMessagesController < ApplicationController
  before_filter :authenticate_user!

  include ActionController::Live

  def index
    @messages = BeginnerMessage.all
  end

  def create
    response.headers["Content-Type"] = "text/javascript"
    attributes = params.require(:beginner_message).permit(:body)
    @message = BeginnerMessage.create(attributes)
    $redis.publish('beginner_messages.create', @message.to_json)
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('beginner_messages.*') do |on|
      on.pbeginner_message do |pattern, event, data|
        response.stream.write("event: #{event}|n")
        response.stream.write("data: #{data}|n|n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end
  
end