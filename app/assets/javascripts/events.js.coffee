$(document).ready ->
  $('#table-events').stupidtable()

  $("#reportrange").daterangepicker
    opens: 'left'
    format: 'dd.MM.yyyy'
    locale:
      applyLabel: "Показать"
      fromLabel: "От"
      toLabel: "До"
      customRangeLabel: "Выбрать интервал"
      daysOfWeek: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
      monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
      firstDay: 1
    ranges:
      "Сегодня": ["today", "today"]
      "За неделю": [Date.today().add(days: -6), "today"]
      "За месяц": [Date.today().add(days: -29), "today"]
      "За текущий месяц": [Date.today().moveToFirstDayOfMonth(), Date.today().moveToLastDayOfMonth()]
      "За прошлый месяц": [Date.today().moveToFirstDayOfMonth().add(months: -1), Date.today().moveToFirstDayOfMonth().add(days: -1)]
  , (start, end) ->
    $("#reportrange").html start.toString("MMMM d, yyyy") + " - " + end.toString("MMMM d, yyyy")

  filter = (selector, query) ->
    query = $.trim(query)
    $(selector).each ->
      if ($(@).text().search(new RegExp(query, "i")) < 0)
        $(@).removeClass('show').addClass('hide')
      else
        $(@).removeClass('hide').addClass('show')

  $("#events-filter").on 'keyup', (event) ->
    if event.keyCode is 27 or $(@).val() is ""
      $(@).val ""
      $("#table-events").find('tbody tr').removeClass('hide').addClass('show')
    else
      filter "#table-events tbody tr", $(@).val()
