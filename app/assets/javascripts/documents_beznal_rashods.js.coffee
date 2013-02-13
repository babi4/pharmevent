$ ->
  $('#documents_beznal_rashod_type_company').on 'change', ->
    if $(@).val() is 'ИП'
      $('#documents_beznal_rashod_nds').attr 'disabled', 'disabled'
    else
      $('#documents_beznal_rashod_nds').removeAttr 'disabled'

  unless $('#documents_beznal_rashod_nds').attr 'disabled'
    $('#documents_beznal_rashod_type_company').trigger 'change'
