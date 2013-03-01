$ ->
  window.changeDocumentState = (state, state_text, url) ->
    if confirm("Поменять статус на \"#{state_text}\"?")
      $.ajax
        type: 'PUT'
        dataType: 'json'
        url: "#{url}/update_state"
        data: 
          transaction: state
        success: (data) ->
          $('.form-validate').submit()

  if window.isDocumentsPage
    documentsStatuses =
      all:
        statuses: [['Все', ''], ['Все незавершенные', 'new'], ['Завершенные', 'completed']]
      documents_beznal_schet:
        statuses: [['Все', ''], ['Новые', 'new'], ['Внесен в 1С', 'added_to_1c'], ['Закрывающие документы готовы', 'ready_to_post'], ['Закрывающие документы отправлены', 'posted'], ['Завершенные', 'completed']]
      documents_beznal_rashod:
        statuses: [['Все', ''], ['Новые', 'new'], ['На подпись', 'added'], ['Подписано', 'signed'], ['На доработку', 'for_revision'], ['Оплачено', 'paid'], ['Закрывающие документы получены', 'received'], ['Завершенные', 'completed']]
      documents_nal_prihod:
        statuses: [['Все', ''], ['Новые', 'new'], ['Оплаченные', 'paid']]
      documents_nal_rashod:
        statuses: [['Все', ''], ['Новые', 'new'], ['Оплаченные', 'paid']]
      company_consumption:
        statuses: [['Все', ''], ['Новые', 'new'], ['На подпись', 'added'], ['Подписано', 'signed'], ['На доработку', 'for_revision'], ['Оплачено', 'paid'], ['Закрывающие документы получены', 'received'], ['Завершенные', 'completed']]

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
      selectDocumentsFilter 'documents_beznal_schet', 'new', 'Новые'

    $('#accountant-pay').on 'click', ->
      selectDocumentsFilter 'documents_beznal_rashod', 'signed', 'Подписано'

    $('#accountant-close').on 'click', ->
      $('#search_only_uncompleted').val('true')
      selectDocumentsFilter 'documents_beznal_schet', 'new', 'Новые'

    $('#admindir-close').on 'click', ->
      selectDocumentsFilter 'documents_beznal_schet', 'ready_to_post', 'Закрывающие документы готовы'

    $('#admindir-return').on 'click', ->
      selectDocumentsFilter 'documents_beznal_rashod', 'received', 'Закрывающие документы получены'

    $('#admindir-receive').on 'click', ->
      selectDocumentsFilter 'documents_beznal_rashod', 'paid', 'Оплачено'

    $('#admindir-return-our').on 'click', ->
      selectDocumentsFilter 'documents_beznal_schet', 'posted', 'Закрывающие документы отправлены'
