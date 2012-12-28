# -*- coding: utf-8 -*-

module Haml::DocumentsHelper
  def links_collection(event, document)
    document_type = document.class.name.underscore

    if can? :read, document
      haml_tag :li, link_to( 'Показать', [event, document] )
    end

    if can? :update, document
      haml_tag :li, link_to( 'Изменить', send( "edit_event_#{document_type}_path", event, document ) )
    end

    if can? :remove, document
      haml_tag :li, link_to( 'Удалить', send( "update_state_event_#{document_type}_path", event, document, transaction: "remove" ), method: :put )
    end

    if can? :send_to_sign, document
      haml_tag :li, link_to( 'Отправить на подпись', send( "update_state_event_#{document_type}_path", event, document, transaction: "send_to_sign" ), method: :put )
    end

    if can? :sign, document
      haml_tag :li, link_to( 'Подписать', send( "update_state_event_#{document_type}_path", event, document, transaction: "sign" ), method: :put )
    end

    if can? :send_for_revision, document
      haml_tag :li, link_to( 'Отправить на доработку', '#changeEventStateModal', "data-url" => send( "update_state_event_#{document_type}_path", event, document, transaction: "send_for_revision" ), "data-title" => 'Отправка на доработку', "data-toggle" => 'modal', class: 'document-state-modal' )
    end

    if can? :pay, document
      haml_tag :li, link_to( 'Оплачено', send( "update_state_event_#{document_type}_path", event, document, transaction: "pay" ), method: :put )
    end

    if can? :block_payment, document
      haml_tag :li, link_to( 'Запретить к оплате', '#changeEventStateModal', "data-url" => send( "update_state_event_#{document_type}_path", event, document, transaction: "block_payment" ), "data-title" => 'Запрет оплаты', "data-toggle" => 'modal', class: 'document-state-modal' )
    end

  end
end
