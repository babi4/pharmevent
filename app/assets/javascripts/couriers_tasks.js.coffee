$ ->
  $companies_select = $('#couriers_task_from_couriers_company_id, #couriers_task_to_couriers_company_id')
  $companies_select.select2()
  $companies_select.on 'change', ->
    company = _.find window.companies, (item) => item.id is parseInt($(@).val())
    $(@).parent().find('.couriers-company-address').text company.full_address

  $companies_select.trigger 'change'

  $('#btn-courier-task-save').on 'click', (e) ->
    e.preventDefault()
    if $('#couriers_task_from_couriers_company_id').val() is $('#couriers_task_to_couriers_company_id').val()
      alert 'Место отправки совпадает с местом получения. Выберите, пожалуйста, правильные места.'
    else
      $('.form-courier-task').submit()
