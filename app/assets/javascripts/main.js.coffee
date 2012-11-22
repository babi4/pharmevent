$ ->
  $('.form-validate').on 'submit', ->
    errors = $(@).find('input').filter(->
      $(@).data("required") and $(@).val().trim() is ""
    ).addClass 'input-required'
    false  if errors.length

  $('.form-validate').on 'blur', '.input-required', ->
    $(@).removeClass('input-required') unless $(@).val().trim() is ""