$ ->
  window.validateForm = (form) ->
    errors = form.find('input').filter(->
      $(@).data("required") and $(@).val().trim() is ""
    ).addClass 'input-required'
    return false  if errors.length
    true

  $('.form-validate').on 'submit', ->
    validateForm $(@)

  $('.form-validate').on 'blur', '.input-required', ->
    $(@).removeClass('input-required') unless $(@).val().trim() is ""