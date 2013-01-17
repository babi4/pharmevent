$ ->

  ymapsGeocode = (routeString) ->
    ymaps.geocode(window.from_address,
      results: 1
    ).then (res) ->
      fromGeoObject = res.geoObjects.get(0).geometry.getCoordinates()
      ymaps.geocode(window.to_address,
        results: 1
      ).then (res) ->
        toGeoObject = res.geoObjects.get(0).geometry.getCoordinates()
        $('#couriers-map-static-img').attr 'src', "http://static-maps.yandex.ru/1.x/?l=map&pl=c:8822DDC0,w:5,#{routeString}&pt=#{fromGeoObject[1]},#{fromGeoObject[0]},pm2am~#{toGeoObject[1]},#{toGeoObject[0]},pm2bm"

  if ymaps? and window.from_address and window.to_address
    ymaps.ready ->

      couriersMap = new ymaps.Map("couriers-map",
        center: [55.76, 37.64]
        zoom: 7
      )

      couriersMap.controls
        .add 'smallZoomControl',
          right: 5
          top: 5

      ymaps.route([window.from_address, window.to_address],
        mapStateAutoApply: true
      ).then ((route) ->
        couriersMap.geoObjects.add route
        routeString = ("#{item[1]},#{item[0]}" for item in route.getPaths().get(0).geometry.getCoordinates())
        ymapsGeocode routeString.slice(0, -1)
      ), (error) ->
        alert "Возникла ошибка: " + error.message

  $('#courier-print').on 'click', ->
    window.print()

  currentModalType = false
  
  $('#btn-courier-task-save').on 'click', (e) ->
    e.preventDefault()
    if $('#couriers_task_from_couriers_company_id').val() is $('#couriers_task_to_couriers_company_id').val()
      alert 'Место отправки совпадает с местом получения. Выберите, пожалуйста, правильные места.'
    else
      $('.form-courier-task').submit()

  setAutocomplete = (type, val, people_val) ->
    $("##{type}-people").on "autocompletecreate", (event, ui) ->
      $(@).val people_val
    $("##{type}-company").on "autocompletecreate", (event, ui) ->
      $(@).val val
      initMembersSelect $("#couriers_task_#{type}_couriers_company_id").val(), type

  initMembersSelect = (company, type) ->
    $.getJSON "/couriers_companies/#{company}/couriers_company_members.json", (data) ->
      $("##{type}-people").val('').autocomplete
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
      .focus ->   
        search_val = $(@).val()
        $(@).data("autocomplete").search(search_val) if search_val is ''

  if window.from_couriers_company
    setAutocomplete 'from', window.from_couriers_company, window.from_couriers_company_member
    setAutocomplete 'to', window.to_couriers_company, window.to_couriers_company_member

  if window.couriers_companies
    $(".company-select").autocomplete
      minLength: 0
      source: ({value: item.name, id: item.id} for item in window.couriers_companies)
      change: (event, ui) ->
        type = $(@).data 'type'
        unless ui.item
          $("#{type}-people").val ''
          $("#couriers-#{type}-company-address").text ''
          $("#couriers-#{type}-member").slideUp(200)
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
        $("#couriers_member_company, #couriers_task_#{type}_couriers_company_id").val ui.item.id
        company_data = _.find window.couriers_companies, (item) -> item.id is parseInt(ui.item.id)
        $("#couriers-#{type}-company-address").text company_data.full_address
        initMembersSelect ui.item.id, type
        $("#couriers-#{type}-member").slideDown(200)
    .focus ->   
      search_val = $(@).val()
      $(@).data("autocomplete").search(search_val) if search_val is ''

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

  $('.btn-courier-member-edit').on 'click', ->
    member_id = parseInt $(@).data('id')
    member_data = _.find window.couriersCompanyMembers, (item) -> item.id is member_id
    $('#form-company-member')
      .attr('action', "/couriers_companies/#{window.couriersCompanyId}/couriers_company_members/#{member_id}")
      .find('input[name=_method]').val 'put'
    $('#company_member_id').val member_data.id
    $('#company_member_name').val member_data.name
    $('#couriers-company-member-name').text member_data.name
    $('#company_member_telephone').val member_data.telephone

  $('#btn-courier-member-add').on 'click', ->
    $('#form-company-member')
    .attr('action', "/couriers_companies/#{window.couriersCompanyId}/couriers_company_members/create")
    .find('input[name=_method]').val 'post'
    $('#company_member_id, #company_member_name, #company_member_telephone').val ''
    $('#couriers-company-member-name').text 'Новое контактное лицо'