# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('body').on('click','.edit-answer-link', (e)->
    $(this).hide();
    answerId = $(this).data('answerId')
    $("form#edit-answer-#{answerId}").show()
    e.preventDefault()
  )

 # $('form.new_answer').bind('ajax:success', (e, data, status, xhr)->
 #   $('#errors').html('');
 #   $('.answers').html(xhr.responseText);
 #   $('#answer_body_create').val('');
 # )
 # .bind "ajax:error", (e, xhr, status, error)->
 #   $('#errors').html(xhr.responseText)
