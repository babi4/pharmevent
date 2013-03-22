$ ->

  unless $('#documents_beznal_rashod_nds').attr 'disabled'
    $('#documents_beznal_rashod_type_company').trigger 'change'

  if window.old_beznal_rashod_state?
    check_state = true
    $('.form-validate').on 'submit', (e) ->
      if check_state
        check_state = false
        doc_date = $("##{window.doc_type}_info_date_pay").val()
        factura = $("##{window.doc_type}_info_schet_factura").val()
        factura_date = $("##{window.doc_type}_info_date_schet").val()
        act = $("##{window.doc_type}_info_act").val()
        act_date = $("##{window.doc_type}_info_date_act").val()
        info_state_act = $("##{window.doc_type}_info_state_act").val()
        if old_beznal_rashod_state == 'signed' and doc_date != ''
          changeDocumentState 'pay', 'Оплачено', window.doc_url
          false
        else if old_beznal_rashod_state == 'paid' and _.compact([factura, factura_date, act, act_date]).length == 4
          changeDocumentState 'receive', 'Документы получены', window.doc_url
          false
        else if old_beznal_rashod_state == 'received' and info_state_act == 'отправлен' and info_state_act != window.old_info_state_act
          changeDocumentState 'complete', 'Завершено', window.doc_url
          false
        else
          true
      else
        true