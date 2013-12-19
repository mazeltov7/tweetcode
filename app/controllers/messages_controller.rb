#coding: utf-8

class MessagesController < ApplicationController

  include ActionController::Live

  def index
    @messages = Message.all.order("created_at DESC")
    @room = Room.find(params[:room_id])
  end


  def create
    response.headers["Content-Type"] = "text/javascript"
    @message = Message.create!(attributes)
    @message.user = current_user
    @message.save

    json_message = @message.to_json
    hash_result = JSON.parse(json_message)
    hash_result[:username] = @message.user.username
    hash_result[:created_at] = @message.created_at.strftime("%H:%M")
    hash_result[:status] = @message.user.status
    @json_result = hash_result.to_json
    $redis.publish('messages.create', @json_result)
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('messages.*') do |on|
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
    params.require(:message).permit(:body, :room_id)
  end

end
