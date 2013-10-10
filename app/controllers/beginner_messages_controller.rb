  #coding: utf-8

class BeginnerMessagesController < ApplicationController

  include ActionController::Live

  def index
    @beginner_messages = BeginnerMessage.all.order("created_at DESC")
   
  end

  def create  
    response.headers["Content-Type"] = "text/javascript"
    attributes = params.require(:beginner_message).permit(:body)
    @beginner_message = BeginnerMessage.new(attributes)
    @beginner_message.user = current_user
    @beginner_message.save

    json_message = @beginner_message.to_json
    hash_result = JSON.parse(json_message)
    hash_result[:username] = @beginner_message.user.username
    hash_result[:created_at] = @beginner_message.created_at.strftime("%H:%M")
    @json_result = hash_result.to_json
    $redis.publish('beginner_messages.create', @json_result)
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('beginner_messages.*') do |on|
      if Rails.env.production?
        messages = BeginnerMessage.where('created_at > ?', Time.current-10)
        puts "-----"
        puts messages.inspect
        messages.each do |me|
          puts "111"
          json_mee = me.to_json
          hash_mee = JSON.parse(json_mee)
          hash_mee[:username] = me.user.username
          hash_mee[:created_at] = me.created_at.strftime("%H:%M")
          puts "#{hash_mee}"
          puts "22"
          me_result = hash_mee.to_json
          response.stream.write("event: 'beginner_messages.create'\n")
          response.stream.write("data: #{me_result}\n\n")
          puts "555"

        end
      else
        puts "888"
        puts "#{on.message}"
        puts "8"
        on.pmessage do |pattern, event, data|
          response.stream.write("event: #{event}\n")
          response.stream.write("data: #{data}\n\n")
        end
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end
  

end