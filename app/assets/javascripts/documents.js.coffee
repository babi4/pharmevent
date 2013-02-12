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
      company_rashod:
        statuses: [['Все', ''], ['Новые', 'new'], ['На подпись', 'unsigned'], ['Подписано / на доработку', 'signed'], ['Оплачено', 'paid'], ['Закрывающие документы получены', 'closed_documents_received'], ['Завершенные', 'finished']]

    $('#documents-filter-type').on 'change', ->
      currentType = $(@).val()
      html = for status in documentsStatuses[currentType].statuses
        "<option value='#{status[1]}'>#{status[0]}</option>"
      $('#documents-filter-status').html html

    $('#documents-filter-type').trigger 'change'
    $('#documents-filter-status').val(window.documentsState) if window.documentsState

    $('#documents-advanced-toggle').on 'click', ->
      $('#documents-advanced-search').slideToggle 300