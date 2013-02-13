$(document).ready ->
  report_daterange = $('#report-daterange')
  report_daterange.daterangepicker
    locale:
      applyLabel: "Сохранить"
      fromLabel: "Начало"
      toLabel: "Конец"
    startDate: Date.parse(report_daterange.data 'datestart')
    endDate: Date.parse(report_daterange.data 'dateend')
  , (start, end) ->
    $('#report-from').val start.toString 'yyyy-MM-dd'
    $('#report-to').val end.toString 'yyyy-MM-dd'