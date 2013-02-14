$ ->
  if window.isDocumentsPage
    documentsStatuses =
      all:
        statuses: [['Новые', 'new'], ['Завершенные', 'completed']]
      beznal_prihod:
        statuses: [['Все', ''], ['Новые', 'new'], ['Внесен в 1С', 'added_to_1c'], ['Закрывающие документы готовы', 'ready_to_post'], ['Закрывающие документы отправлены', 'posted'], ['Завершенные', 'completed']]
      beznal_rashod:
        statuses: [['Все', ''], ['Новые', 'new'], ['На подпись', 'unsigned'], ['Подписано / на доработку', 'signed'], ['Оплачено', 'paid'], ['Закрывающие документы получены', 'received'], ['Завершенные', 'completed']]
      nal_prihod:
        statuses: [['Все', ''], ['Новые', 'new'], ['Оплаченные', 'paid']]
      nal_rashod:
        statuses: [['Все', ''], ['Новые', 'new'], ['Оплаченные', 'paid']]
      company_consumption:
        statuses: [['Все', ''], ['Новые', 'new'], ['На подпись', 'unsigned'], ['Подписано / на доработку', 'signed'], ['Оплачено', 'paid'], ['Закрывающие документы получены', 'closed_documents_received'], ['Завершенные', 'finished']]

    $('#documents-filter-type').on 'change', ->
      currentType = $(@).val()
      html = for status in documentsStatuses[currentType].statuses
        "<option value='#{status[1]}'>#{status[0]}</option>"
      $('#documents-filter-status').html(html)
      $('#documents-filter-status').trigger('updatecomplete')

    $('#documents-filter-type').trigger 'change'
    $('#documents-filter-status').val(window.documentsState) if window.documentsState

    $('#documents-advanced-toggle').on 'click', ->
      $('#documents-advanced-search').slideToggle 300

    $('#accountant-new').on 'click', ->
      $('#documents-advanced-search').find('input').val('')
      $('#documents-filter-type').val('beznal_prihod')
      $('#documents-filter-status').val('new')
      $('#documents-search-submit').click()
      false

    $('#accountant-pay').on 'click', ->
      $('#documents-advanced-search').find('input').val('')
      $('#documents-filter-type').val('beznal_rashod')
      $('#documents-filter-status').html("<option value='signed'>Подписано / на доработку</option>").val('signed')
      $('#documents-search-submit').click()
      false

    $('#accountant-close').on 'click', ->
      $('#documents-advanced-search').find('input').val('')
      $('#documents-filter-type').val('beznal_prihod')
      $('#only_uncompleted').val('true')
      $('#documents-search-submit').click()
      false

    $('#admindir-close').on 'click', ->
      $('#documents-advanced-search').find('input').val('')
      $('#documents-filter-type').val('beznal_prihod')
      $('#documents-filter-status').html("<option value='ready_to_post'>Закрывающие документы готовы</option>").val('ready_to_post')
      $('#documents-search-submit').click()
      false

    $('#admindir-return').on 'click', ->
      $('#documents-advanced-search').find('input').val('')
      $('#documents-filter-type').val('beznal_rashod')
      $('#documents-filter-status').html("<option value='received'>Закрывающие документы получены</option>").val('received')
      $('#documents-search-submit').click()
      false

    $('#admindir-receive').on 'click', ->
      $('#documents-advanced-search').find('input').val('')
      $('#documents-filter-type').val('beznal_rashod')
      $('#documents-filter-status').html("<option value='paid'>Оплачено</option>").val('paid')
      $('#documents-search-submit').click()
      false
