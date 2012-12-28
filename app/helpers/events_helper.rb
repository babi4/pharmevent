# encoding: utf-8

module EventsHelper
  def event_state_text(state)
    case state
    when 'new'
      'Новый'
    when 'added'
      'На подпись'
    when 'signed'
      'Подписан'
    when 'for_revision'
      'На доработку'
    when 'paid'
      'Оплачен'
    when 'not_for_payment'
      'Запрещен к оплате'
    end
  end
end
