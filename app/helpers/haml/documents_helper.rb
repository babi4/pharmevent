# -*- coding: utf-8 -*-

module Haml::DocumentsHelper
  def links_collection(event, document)
    document_type = ActiveModel::Naming.singular_route_key(document)

    if can? :update, document
      haml_tag :li, link_to( 'Изменить', send( "edit_event_#{document_type}_path", event.id, document ) )
    end

    if can? :remove, document
      haml_tag :li, link_to( 'Удалить', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "remove" ), method: :put, data: { confirm: 'Удалить документ?' } )
    end

    if can? :send_to_sign, document
      haml_tag :li, link_to( 'Отправить на подпись', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "send_to_sign" ), method: :put )
    end

    if can? :sign, document
      haml_tag :li, link_to( 'Подписать', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "sign" ), method: :put )
    end

    if can? :send_for_revision, document
      haml_tag :li, link_to( 'Отправить на доработку', '#changeEventStateModal', "data-url" => send( "update_state_event_#{document_type}_path", event.id, document, transaction: "send_for_revision" ), "data-title" => 'Отправка на доработку', "data-toggle" => 'modal', class: 'document-state-modal' )
    end

    if can? :revise, document
      haml_tag :li, link_to( 'Исправлено', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "revise" ), method: :put )
    end

    if can? :pay, document
      haml_tag :li, link_to( 'Оплачено', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "pay" ), method: :put )
    end

    if can? :receive, document
      haml_tag :li, link_to( 'Документы получены', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "receive" ), method: :put )
    end

    if can? :block_payment, document
      haml_tag :li, link_to( 'Запретить к оплате', '#changeEventStateModal', "data-url" => send( "update_state_event_#{document_type}_path", event.id, document, transaction: "block_payment" ), "data-title" => 'Запрет оплаты', "data-toggle" => 'modal', class: 'document-state-modal' )
    end

    if can? :add_to_1c, document
      haml_tag :li, link_to( 'Внесено в 1С', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "add_to_1c" ), method: :put )
    end

    if can? :set_ready_to_post, document
      haml_tag :li, link_to( 'Документы готовы', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "set_ready_to_post" ), method: :put )
    end

    if can? :post, document
      haml_tag :li, link_to( 'Документы отправлены', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "post" ), method: :put )
    end

    if can? :complete, document
      haml_tag :li, link_to( 'Завершено', send( "update_state_event_#{document_type}_path", event.id, document, transaction: "complete" ), method: :put )
    end

  end
end
