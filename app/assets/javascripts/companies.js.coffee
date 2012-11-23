$ ->
  $companyModal = $('#companyMemberModal')
  $('#newCompanyMember').on 'click', ->
    $companyModal.find('h3').text 'Новый представитель'
    $('#memberId, #memberName, #memberPhone, #memberPosition, #memberEmail').val ''
    $('#save-member').text 'Добавить'
    $('#delete-member').hide()

  $('.company-members').on 'click', '.company-member-edit', ->
    memberId = $(@).parent('li').data('member-id')
    currentMember = _.find window.companyMembers, (member) -> member.id is memberId
    $companyModal.find('h3').text currentMember.name

    $('#memberId').val memberId
    $('#memberName').val currentMember.name
    $('#memberPhone').val currentMember.telephone
    $('#memberPosition').val currentMember.position
    $('#memberEmail').val currentMember.email

    $('#save-member').text 'Сохранить'
    $('#delete-member').show()

  $('#save-member').on 'click', ->
    if validateForm $('#companyMemberModal')
      $.post '/company_members/update',
        company_member:
          company_id: $('#companyId').val()
          id: $('#memberId').val()
          name: $('#memberName').val().trim()
          position: $('#memberPosition').val().trim()
          telephone: $('#memberPhone').val().trim()
          email: $('#memberEmail').val().trim()
        (data) -> 
          member_html = "<a class='company-member-edit' data-toggle='modal' href='#companyMemberModal'>#{data.company_member.name}</a>"
          unless data.company_member.position is ''
            member_html += ", #{data.company_member.position}"
          if data.company_member.telephone != '' and data.company_member.email != ''
            member_html += "<br>#{data.company_member.telephone}, <a href='mailto:#{data.company_member.email}'>#{data.company_member.email}</a>"
          else if data.company_member.telephone != '' or data.company_member.email != ''
            member_html += "<br>#{data.company_member.telephone}<a href='mailto:#{data.company_member.email}'>#{data.company_member.email}</a>"

          if data.member_action is 'edit'
            member = _.find window.companyMembers, (item) -> item.id == data.company_member.id
            member = data.company_member
            $('.company-members').find("li[data-member-id='#{member.id}']").html member_html
          else
            window.companyMembers.push data.company_member
            $('.company-members').append "<li data-member-id='#{data.company_member.id}'>#{member_html}</li>"

          $('#companyMemberModal').modal 'hide'

  $('#delete-member').on 'click', ->
    if confirm 'Вы уверены?'
      $.post "/company_members/destroy",
        id: $('#memberId').val()
        company_id: $('#companyId').val()
        (data) ->
          $('.company-members').find("li[data-member-id='#{data}']").remove()
          member = _.find window.companyMembers, (item) -> item.id is data
          index = window.companyMembers.indexOf member
          window.companyMembers.splice index, 1
          $('#companyMemberModal').modal 'hide'