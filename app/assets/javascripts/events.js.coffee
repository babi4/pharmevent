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