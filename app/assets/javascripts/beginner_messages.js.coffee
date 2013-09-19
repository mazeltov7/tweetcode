# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

source = new EventSource('/beginner_messages/events')
source.addEventListener 'beginner_messages.create', (e) ->
  beginner_message = $.parseJSON(e.data).beginner_message
  $('#chat').append($('<li>').text("#{beginner_message.body}"))