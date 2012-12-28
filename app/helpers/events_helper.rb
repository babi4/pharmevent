# encoding: utf-8

module EventsHelper
  def event_state_text(state)
    case state
    when 'new'
      content_tag 'span', 'Новый', class: 'label'
    when 'added'
      content_tag 'span', 'На подпись', class: 'label label-info'
    when 'signed'
      content_tag 'span', 'Подписан', class: 'label label-important'
    when 'for_revision'
      content_tag 'span', 'На доработку', class: 'label label-info'
    when 'paid'
      content_tag 'span', 'Оплачен', class: 'label label-success'
    when 'not_for_payment'
      content_tag 'span', 'Запрещен к оплате', class: 'label label-warning'
    end
  end
end
