$(document).ready ->
  event_daterange = $('#event-daterange')
  event_daterange.daterangepicker
    opens: event_daterange.data 'opens'
    locale:
      applyLabel: "Сохранить"
      fromLabel: "Начало"
      toLabel: "Конец"
    startDate: Date.parse(event_daterange.data 'datestart')
    endDate: Date.parse(event_daterange.data 'dateend')
  , (start, end) ->
    $('#event-start').val start.toString 'yyyy-MM-dd'
    $('#event-end').val end.toString 'yyyy-MM-dd'

  $('.event-to-archive').on 'click', ->
    event_id = $(@).data 'event-id'
    $.post "/events/#{event_id}/switch_archive", (data) =>
      $(@).closest('tr').fadeOut(250) if data.succ
    false

  $('.document-state-modal').on 'click', ->
    $('#document-state-title').text $(@).data 'title'
    $('#document-state-save').attr 'href', $(@).data 'url'

  $('#document-state-save').on 'click', (e) ->
    e.preventDefault()
    link = $(@).attr('href') + '&state_note=' + $('#document_state_note').val()
    $(@).attr('href', link)