# -*- coding: utf-8 -*-

module Haml::DocumentsHelper
  def links_collection(event, document)
    document_type = document.class.name.underscore

    if can? :read, document
      haml_tag :td, link_to( 'Show', [event, document] )
    end

    if can? :update, document
      haml_tag :td, link_to( 'Edit', send( "edit_event_#{document_type}_path", event, document ) )
    end

    if can? :remove, document
      haml_tag :td, button_to( 'Удалить //(почти)\\', send( "update_state_event_#{document_type}_path", event, document, transaction: "remove" ), method: :put )
    end

    if can? :send_to_sign, document
      haml_tag :td, button_to( 'Отправить на подпись', send( "update_state_event_#{document_type}_path", event, document, transaction: "send_to_sign" ), method: :put )
    end

    if can? :sign, document
      haml_tag :td, button_to( 'Подписать', send( "update_state_event_#{document_type}_path", event, document, transaction: "sign" ), method: :put )
    end

    if can? :send_for_revision, document
      haml_tag :td, button_to( 'Отправить на доработку', send( "update_state_event_#{document_type}_path", event, document, transaction: "send_for_revision" ), method: :put )
    end

    if can? :pay, document
      haml_tag :td, button_to( 'Оплачено', send( "update_state_event_#{document_type}_path", event, document, transaction: "pay" ), method: :put )
    end

    if can? :block_payment, document
      haml_tag :td, button_to( 'Запретить к оплате', send( "update_state_event_#{document_type}_path", event, document, transaction: "block_payment" ), method: :put )
    end

  end
end
