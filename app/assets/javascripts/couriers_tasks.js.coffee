$ ->
  currentModalType = false
  
  $('#btn-courier-task-save').on 'click', (e) ->
    e.preventDefault()
    if $('#couriers_task_from_couriers_company_id').val() is $('#couriers_task_to_couriers_company_id').val()
      alert 'Место отправки совпадает с местом получения. Выберите, пожалуйста, правильные места.'
    else
      $('.form-courier-task').submit()

  initMembersSelect = (company, type) ->
    $("#couriers_member_company, #couriers_task_#{type}_couriers_company_id").val company
    company_data = _.find window.couriers_companies, (item) -> item.id is parseInt(company)
    $("#couriers-#{type}-company-address").text company_data.full_address
    $.getJSON "/couriers_companies/#{company}/couriers_company_members.json", (data) ->
      $("##{type}-people").autocomplete
        autoFocus: true
        minLength: 0
        source: ({value: item.name, id: item.id} for item in data)
        response: (event, ui) ->
          if ui.content.length
            $("#new-#{type}-company-member").addClass('hide')
          else
            $("#new-#{type}-company-member").removeClass('hide')
        select: (event, ui) ->
          type = $(@).data 'type'
          $("#couriers_task_#{type}_couriers_company_member_id").val ui.item.id


  if window.couriers_companies
    $(".company-select").autocomplete
      autoFocus: true
      minLength: 0
      source: ({value: item.name, id: item.id} for item in window.couriers_companies)
      change: (event, ui) ->
        type = $(@).data 'type'
        $("#couriers-#{type}-member").slideUp(200) unless ui.item
      response: (event, ui) ->
        type = $(@).data 'type'
        if ui.content.length
          $("#new-#{type}-company").addClass('hide')
          if ui.content.length > 1
            $("#couriers-#{type}-member").slideUp(200)
        else
          $("#new-#{type}-company").removeClass('hide')
          $("#couriers-#{type}-member").slideUp(200)
      select: (event, ui) ->
        type = $(@).data 'type'
        initMembersSelect ui.item.id, type
        $("#couriers-#{type}-member").slideDown(200)

  $('.new-company').on 'click', ->
    type = $(@).data 'type'
    currentModalType = type
    $('#couriers_company_name').val $("##{type}-company").val()

  $('.new-company-member').on 'click', ->
    type = $(@).data 'type'
    currentModalType = type
    $('#couriers_member_name').val $("##{type}-people").val()

  $('#courier-company-member-add').on 'click', ->
    if validateForm($('#form-company-member'))
      company_id = $('#couriers_member_company').val().trim()
      $.post "/couriers_companies/#{company_id}/couriers_company_members/create",
        company_member:
          name: $('#couriers_member_name').val().trim()
          telephone: $('#couriers_member_telephone').val().trim()
        company_id: company_id
        (data) ->
          initMembersSelect company_id
          $("#couriers_task_#{currentModalType}_couriers_company_member_id").val data.id
          $("#{currentModalType}-people").val data.name
          $("#new-#{currentModalType}-company-member").hide()
          $('#newMemberModal').modal 'hide'
          $('#couriers_member_telephone').val ''