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
    autoclose: true
  ).on "changeDate", (ev) ->
    new_date = ev.date.toString 'dd.MM.yyyy'
    if @nodeName is 'SPAN'
      $($(@).data('field')).val new_date
      $(@).text new_date
    else
      $(@).find('.input-date').val new_date

  $('.timepicker').timepicker
    defaultTime: 'value'
    showMeridian: false

  $('.table-links').on 'click', 'tbody tr', (e) ->
    window.location = $(@).data 'link' if e.target.tagName is 'TD'

  filter = ''
  filter_start = false
  filter_end = false

  hideItem = ($el) ->
    $el.removeClass('show').addClass('hide')

  showItem = ($el) ->
    $el.removeClass('hide').addClass('show')

  betweenDates = (date) ->
    item_date = date * 1000
    item_date >= filter_start and item_date <= filter_end

  filterItems = =>
    $items_list = $('#table-filter').find('tbody tr')
    if filter is '' and !filter_start and !filter_end
      $items_list.removeClass('hide').addClass('show')
    else
      if filter_start and filter_end
        $items_list.each ->
          $item_row = $(@)
          date_check = false
          $item_row.find('.filter-date').each ->
            if betweenDates $(@).data('sort-value')
              date_check = true
              false
          if date_check and (filter is '' or $(@).text().search(new RegExp(filter, "i")) > -1)
            showItem $item_row
          else
            hideItem $item_row
      else
        $items_list.each ->
          $item_row = $(@)
          if ($item_row.text().search(new RegExp(filter, "i")) < 0)
            hideItem $item_row
          else
            showItem $item_row

  $('#table-filter').stupidtable()

  $reportrange_field = $("#reportrange")

  date_range_start = Date.parse($reportrange_field.data('start-date')) || Date.today()
  date_range_end   = Date.parse($reportrange_field.data('end-date')) || Date.today()

  $reportrange_field.daterangepicker
    opens: 'right'
    startDate: date_range_start
    endDate: date_range_end
    ranges:
      "Сегодня": ["today", "today"]
      "За неделю": [Date.today().add(days: -6), "today"]
      "За 30 дней": [Date.today().add(days: -30), "today"]
      "За текущий месяц": [Date.today().moveToFirstDayOfMonth(), Date.today().moveToLastDayOfMonth()]
      "За прошлый месяц": [Date.today().moveToFirstDayOfMonth().add(months: -1), Date.today().moveToFirstDayOfMonth().add(days: -1)]
      "За все время": ['', '']
  , (start, end) ->
    if @.active
      start_date = start.toString 'dd.MM.yyyy'
      end_date = end.toString 'dd.MM.yyyy'
      filter_start = start.getTime()
      filter_end = end.getTime()
      if start_date is end_date
        date_range = start_date
      else
        date_range = "#{start_date} - #{end_date}"
    else
      filter_start = false
      filter_end = false
      date_range = ''
    filterItems()
    $("#reportrange").val date_range

  if $reportrange_field.data('start-date') && $reportrange_field.data('end-date')
    filter_start = date_range_start.getTime()
    filter_end   = date_range_end.getTime()
    filterItems()

  $("#input-filter").on 'keyup', (event) ->
    filter = $(@).val().trim()
    filterItems()