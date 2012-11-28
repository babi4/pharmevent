$ ->
  filterClients = (filter) =>
    $clients_list = $('#table-clients').find('tbody tr')
    if filter is ''
      $clients_list.removeClass('hide').addClass('show')
    else
      $clients_list.each ->
        $client_row = $(@)
        if ($client_row.text().search(new RegExp(filter, "i")) < 0)
          $client_row.removeClass('show').addClass('hide')
        else
          $client_row.removeClass('hide').addClass('show')

  $("#clients-filter").on 'keyup', (event) ->
    filterClients $(@).val().trim()