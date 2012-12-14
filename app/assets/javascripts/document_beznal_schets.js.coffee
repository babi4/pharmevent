$ ->
  $('#documents_beznal_schet_company_id').on 'change', ->
    company = _.find(window.companies, (item) => item.id is parseInt($(@).val(), 10))
    if company.ur_post_equal
      address = "#{company.ur_zip_code}, г.#{company.ur_city}, ул.#{company.ur_street}, #{company.ur_hous}"
      address += ", строение #{company.ur_stroenie}" unless company.ur_stroenie is '' or company.ur_stroenie?
      address += ", офис #{company.ur_office}" unless company.ur_office is '' or company.ur_office?
    else
      address = "#{company.post_zip_code}, г.#{company.post_city}, #{company.post_street}, #{company.post_house}"
      address += ", строение #{company.post_stroenie}" unless company.post_stroenie is '' or !company.post_stroenie?
      address += ", офис #{company.post_office}" unless company.post_office is '' or !company.post_office?
      
    $('#address-company').text address

  $('#documents_beznal_schet_company_id').trigger 'change'