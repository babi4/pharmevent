# encoding: utf-8

module EventsHelper
  def event_state_text(state)
    case state
    when 'new'
      content_tag 'span', 'Новый', class: 'label'
    when 'added_to_1c'
      content_tag 'span', 'Внесен в 1C', class: 'label label-info'
    when 'ready_to_post'
      content_tag 'span', 'Документы готовы', class: 'label label-info'
    when 'posted'
      content_tag 'span', 'Документы отправлены', class: 'label label-info'
    when 'received'
      content_tag 'span', 'Документы получены', class: 'label label-info'
    when 'completed'
      content_tag 'span', 'Завершено', class: 'label label-success'
    #when 'added'
    #  content_tag 'span', 'На подпись', class: 'label label-info'
    when 'signed'
      content_tag 'span', 'Подписан', class: 'label label-important'
    when 'for_revision'
      content_tag 'span', 'На доработку', class: 'label label-info'
    when 'revised'
      content_tag 'span', 'Исправлено', class: 'label label-important'
    when 'paid'
      content_tag 'span', 'Оплачен', class: 'label label-success'
    #when 'not_for_payment'
    #  content_tag 'span', 'Запрещен к оплате', class: 'label label-warning'
    end
  end
end
