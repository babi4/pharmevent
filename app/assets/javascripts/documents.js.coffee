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

    selectDocumentsFilter = (type, status, statusText) ->
      $('#documents-advanced-search').find('input').val('')
      $('#documents-filter-type').val(type)
      $('#documents-filter-status').html("<option value='#{status}'>#{statusText}</option>").val(status)
      $('#documents-search-submit').click()
      false

    $('#accountant-new').on 'click', ->
      selectDocumentsFilter 'beznal_prihod', 'new', 'Новые'

    $('#accountant-pay').on 'click', ->
      selectDocumentsFilter 'beznal_rashod', 'signed', 'Подписано / на доработку'

    $('#accountant-close').on 'click', ->
      $('#only_uncompleted').val('true')
      selectDocumentsFilter 'beznal_prihod', 'new', 'Новые'

    $('#admindir-close').on 'click', ->
      selectDocumentsFilter 'beznal_prihod', 'ready_to_post', 'Закрывающие документы готовы'

    $('#admindir-return').on 'click', ->
      selectDocumentsFilter 'beznal_rashod', 'received', 'Закрывающие документы получены'

    $('#admindir-receive').on 'click', ->
      selectDocumentsFilter 'beznal_rashod', 'paid', 'Оплачено'

    $('#admindir-return-our').on 'click', ->
      selectDocumentsFilter 'beznal_prihod', 'posted', 'Закрывающие документы отправлены'
