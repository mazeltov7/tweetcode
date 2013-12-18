# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

source = new EventSource('/beginner_messages/events')
source.addEventListener 'beginner_messages.create', (e) ->
  beginner_message = $.parseJSON(e.data)
  $('#chat').prepend($('<td class="text-success">').text("#{beginner_message.username}"), $('<td class="text-info">').text("(#{beginner_message.status})"),$('<td>').text(" $ #{beginner_message.body}"),$('<td class="text-warning">').text(" #{beginner_message.created_at}"))