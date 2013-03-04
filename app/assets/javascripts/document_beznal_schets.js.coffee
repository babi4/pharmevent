$ ->
  $('#documents_beznal_schet_company_id').on 'change', ->
    $('#documents_beznal_schet_telephone').val ''
    company = _.find(window.companies, (item) => item.id is parseInt($(@).val(), 10))
    if company?
      if company.ur_post_equal
        address = "#{company.ur_zip_code}, г.#{company.ur_city}, ул.#{company.ur_street}, #{company.ur_hous}"
        address += ", строение #{company.ur_stroenie}" unless company.ur_stroenie is '' or company.ur_stroenie?
        address += ", офис #{company.ur_office}" unless company.ur_office is '' or company.ur_office?
      else
        address = "#{company.post_zip_code}, г.#{company.post_city}, #{company.post_street}, #{company.post_house}"
        address += ", строение #{company.post_stroenie}" unless company.post_stroenie is '' or !company.post_stroenie?
        address += ", офис #{company.post_office}" unless company.post_office is '' or !company.post_office?

      $('#address-company').text address

      if company.company_members?
        window.companyMembers = company.company_members
        select_html = ("<option value='#{member.name}'>#{member.name}</option>" for member in company.company_members)
        select_html = '<option value=""></option>' + select_html
        $('#documents_beznal_schet_name').html select_html

        if window.docName?
          $("#documents_beznal_schet_name [value='#{window.docName}']").attr 'selected', 'selected'
      else
        window.companyMembers = []
        $('#documents_beznal_schet_name').html ''

  $('#documents_beznal_schet_name').on 'change', ->
    company_member = _.find window.companyMembers, (item) => item.name == $(@).val()
    if company_member
      $('#documents_beznal_schet_telephone').val company_member.telephone
    else
      $('#documents_beznal_schet_telephone').val ''

  $('#documents_beznal_schet_company_id, #documents_beznal_schet_name').trigger 'change'

  $('#documents_beznal_schet_summ').on 'keyup', ->
    if $('#auto_nds').attr('checked')
      nds = $(@).val() * 18 / 118
      $('#documents_beznal_schet_nds').val nds.toFixed(2)

  $('#auto_nds').on 'change', ->
    if $(@).attr('checked')
      nds = $('#documents_beznal_schet_summ').val() * 18 / 118
      $('#documents_beznal_schet_nds').val nds.toFixed(2)

  if window.old_state? and window.old_state_act?
    check_state = true
    $('.form-validate').on 'submit', (e) ->
      if check_state
        check_state = false
        new_state_act = $("##{window.doc_type}_info_state_act").val()
        new_return_status = $("##{window.doc_type}_info_return_status").val()
        factura = $("##{window.doc_type}_info_schet_factura").val()
        factura_date = $("##{window.doc_type}_info_date_schet").val()
        act = $("##{window.doc_type}_info_act").val()
        act_date = $("##{window.doc_type}_info_date_act").val()
        if (new_state_act is 'отправлен' and new_state_act != old_state_act and old_state is 'ready_to_post')
          changeDocumentState 'post', 'Документы отправлены', window.doc_url
          false
        else if (new_return_status is 'получен' and new_return_status != old_return_status)
          changeDocumentState 'complete', 'Завершено', window.doc_url
          false
        else if old_state == 'added_to_1c' and _.compact([factura, factura_date, act, act_date]).length == 4
          changeDocumentState 'set_ready_to_post', 'Документы готовы', window.doc_url
          false
        else
          true
      else
        true