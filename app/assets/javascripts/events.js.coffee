$(document).ready ->

  events_filter = ''
  events_start = false
  events_end = false

  hideEvent = ($el) ->
    $el.removeClass('show').addClass('hide')

  showEvent = ($el) ->
    $el.removeClass('hide').addClass('show')

  betweenDates = (date) ->
    event_date = date * 1000
    event_date >= events_start and event_date <= events_end

  filterEvents = =>
    $events_list = $('#table-events').find('tbody tr')
    if events_filter is '' and !events_start and !events_end
      $events_list.removeClass('hide').addClass('show')
    else
      if events_start and events_end
        $events_list.each ->
          $event_row = $(@)
          if betweenDates($event_row.find('.events-start').data('order-by')) or betweenDates($event_row.find('.events-end').data('order-by'))
            if events_filter is '' or $(@).text().search(new RegExp(events_filter, "i")) > -1
              showEvent $event_row
            else
              hideEvent $event_row
          else
            hideEvent $event_row
      else
        $events_list.each ->
          $event_row = $(@)
          if ($event_row.text().search(new RegExp(events_filter, "i")) < 0)
            hideEvent $event_row
          else
            showEvent $event_row

  $('#table-events').stupidtable()
  $('#table-events').on 'click', 'tbody tr', (e) ->
    window.location = $(@).data 'link' if e.target.tagName is 'TD'

  $("#reportrange").daterangepicker
    opens: 'left'
    ranges:
      "Сегодня": ["today", "today"]
      "За неделю": [Date.today().add(days: -6), "today"]
      "За текущий месяц": [Date.today().moveToFirstDayOfMonth(), Date.today().moveToLastDayOfMonth()]
      "За прошлый месяц": [Date.today().moveToFirstDayOfMonth().add(months: -1), Date.today().moveToFirstDayOfMonth().add(days: -1)]
      "За все время": ['', '']
  , (start, end) ->
    if @.active
      start_date = start.toString 'dd.MM.yyyy'
      end_date = end.toString 'dd.MM.yyyy'
      events_start = start.getTime()
      events_end = end.getTime()
      if start_date is end_date
        date_range = start_date
      else
        date_range = "#{start_date} - #{end_date}"
    else
      events_start = false
      events_end = false
      date_range = ''
    filterEvents()
    $("#reportrange").val date_range

  $("#events-filter").on 'keyup', (event) ->
    events_filter = $(@).val().trim()
    filterEvents()

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