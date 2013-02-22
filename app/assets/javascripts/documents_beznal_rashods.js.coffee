$ ->
  $('#documents_beznal_rashod_type_company').on 'change', ->
    if $(@).val() is 'ИП'
      $('#documents_beznal_rashod_nds').attr 'disabled', 'disabled'
    else
      $('#documents_beznal_rashod_nds').removeAttr 'disabled'

  unless $('#documents_beznal_rashod_nds').attr 'disabled'
    $('#documents_beznal_rashod_type_company').trigger 'change'

  if window.old_beznal_rashod_state? and window.old_beznal_rashod_state == 'signed'
    check_state = true
    $('.form-validate').on 'submit', (e) ->
      if check_state
        check_state = false
        doc_date = $("##{window.doc_type}_info_date_pay").val()
        if doc_date != '' and confirm('Поменять статус на "Оплачено"?')
          $.ajax
            type: 'PUT'
            dataType: 'json'
            url: "#{window.doc_url}/update_state"
            data: 
              transaction: 'pay'
            success: (data) ->
              $('.form-validate').submit()
          false
        else
          true
      else
        true