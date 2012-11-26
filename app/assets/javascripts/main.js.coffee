$ ->
  window.validateForm = (form) ->
    errors = form.find('input, select').filter(->
      $(@).data("required") and $(@).val().trim() is ""
    ).addClass 'input-required'
    return false  if errors.length
    true

  $('.form-validate').on 'submit', ->
    validateForm $(@)

  $('.form-validate').on 'blur', '.input-required', ->
    $(@).removeClass('input-required') unless $(@).val().trim() is ""

  $('.date-picker').datepicker(
    format: 'dd.mm.yyyy'
    weekStart: 1
  ).on "changeDate", (ev) ->
    new_date = ev.date.toString 'dd.MM.yyyy'
    $(@).find('.input-date').val new_date

  $('.timepicker').timepicker
    defaultTime: 'value'
    showMeridian: false