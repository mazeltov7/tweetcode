# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

source = new EventSource('/rooms/:room_id/messages/events')
source.addEventListener 'messages.create', (e) ->
  message = $.parseJSON(e.data)
  console.log 'hoge'
  $('#chat').prepend($('<td class="text-success">').text("#{message.username}"), $('<td class="text-info">').text("(#{message.status})"),$('<td>').text(" $ #{message.body}"),$('<td class="text-warning">').text(" #{message.created_at}"))