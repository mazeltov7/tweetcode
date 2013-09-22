# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

source = new EventSource('/beginner_messages/events')
console.log source
source.addEventListener 'beginner_messages.create', (e) ->
  console.log source
  beginner_message = $.parseJSON(e.data).message
  $('#chat').append($('<li>').text("#{beginner_message.body}"))