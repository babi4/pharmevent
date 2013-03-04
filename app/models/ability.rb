# -*- coding: utf-8 -*-

class Ability
  include CanCan::Ability

  def initialize(user = nil)
    @user = user || User.new # for guest
    @user.roles.each { |role| send(role.name) }
    unless @user.roles.exists?
      #can :read, :all #for guest without roles
    end
  end

  def general_director
    # Генеральный директор: видит все проекты всех менеджеров.
    # Финансовые показатели мероприятия: рентабильность, прибыль.

    can :manage, Event
    can :manage, CouriersTask    # Заказ, управление курьерами
    can :manage, CouriersCompany # Управление местами доставки для курьеров
    can :manage, CouriersCompanyMember # Управление контактыми лицами в местах доставки для курьеров
    can :manage, Client          # Управление клиентской базой
    can :manage, CompanyMember   # Управление предствителями заказчика
    can :manage, Company         # Управление заказчиками
    can :manage, User            # Управление учётными записями/правами
    can :manage, :user_passwords # Изменение паролей пользователей
    can :manage, :company_consumption  #Расходы компании
    can :access, :profitability  # Рентабельность

    # ========= ****** =========
    [DocumentsBeznalRashod].each do |document|
      can :read, document
      can :create, document
      can :update, document
      can :remove, document

      can :send_to_sign, document, :state => %w[new]
      can :sign, document, :state => %w(added for_revision)
      can :send_for_revision, document, :state => %w(added)
      can :pay, document, :state => 'signed'
      can :receive, document, :state => 'paid'
      can :complete, document, :state => 'received'
      can :update_state, document
    end

    # ========= ****** =========
    [DocumentsBeznalSchet].each do |document|
      can :read, document
      can :create, document
      can :update, document
      can :remove, document
      can :update_state, document

      can :add_to_1c, document, :state => 'new'
      can :set_ready_to_post, document, :state => 'added_to_1c'
      can :post, document, :state => 'ready_to_post'
      can :complete, document, :state => 'posted'
    end

    # ========= ****** =========
    [DocumentsNalPrihod, DocumentsNalRashod].each do |document|
      can :read, document
      can :create, document
      can :update, document
      can :remove, document

      can :pay, document, :state => 'new'
      can :update_state, document
    end
  end

  def administrative_director
    # Администратор: следит за курьерами,
    # входящими и исходящими задолжностями.

    can :manage, Event
    can :manage, CouriersTask    # Заказ, управление курьерами
    can :manage, CouriersCompany # Управление местами доставки для курьеров
    can :manage, CouriersCompanyMember # Управление контактыми лицами в местах доставки для курьеров
    can :manage, CompanyMember   # Управление предствителями заказчика
    can :manage, Company         # Управление заказчиками
    can :manage, :company_consumption  #Расходы компании

    # ========= ****** =========
    [DocumentsNalRashod, DocumentsNalPrihod].each do |document|
      can :read, document
    end

    # ========= ****** =========
    [DocumentsBeznalRashod].each do |document|
      can :read, document
      can :update, document, :state => 'received'

      can :complete, document, :state => 'received'
      can :update_state, document
    end

    # ========= ****** =========
    [DocumentsBeznalSchet].each do |document|
      can :read, document
      can :update, document, :state => %w(ready_to_post posted completed)
      can :update_state, document, :state => %w(ready_to_post posted)
      can :remove, document, :state => %w(ready_to_post posted completed)

      can :post, document, :state => 'ready_to_post'
      can :complete, document, :state => 'posted'
    end

  end

  def chief_accountant
    # Главный Бухгалтер: видит что создают менеджеры,
    # подтверждает/создает счета,
    # ставит счетам соответствующие статусы.

    can :manage, Event
    can :manage, CouriersTask    # Заказ, управление курьерами
    can :manage, CouriersCompany # Управление местами доставки для курьеров
    can :manage, CouriersCompanyMember # Управление контактыми лицами в местах доставки для курьеров
    # can :manage, Client          # Управление клиентской базой
    can :manage, CompanyMember   # Управление предствителями заказчика
    can :manage, Company         # Управление заказчиками
    can :manage, :company_consumption  #Расходы компании
    can :access, :profitability  # Рентабельность


    # ========= ****** =========
    [DocumentsBeznalRashod].each do |document|
      can :read, document
      can :update, document, :state => %w(signed paid received)
      can :remove, document, :state => %w(signed paid received)

      can :pay, document, :state => 'signed'
      can :receive, document, :state => 'paid'
      can :update_state, document
    end

    # ========= ****** =========
    [DocumentsBeznalSchet].each do |document|
      can :read, document
      can :update, document, :state => %w(new added_to_1c ready_to_post)
      can :remove, document, :state => %w(new added_to_1c ready_to_post)

      can :add_to_1c, document, :state => 'new'
      can :set_ready_to_post, document, :state => 'added_to_1c'
      can :receive, document, :state => 'paid'
      can :complete, document, :state => 'received'
      can :update_state, document
    end

    # ========= ****** =========
    [DocumentsNalPrihod, DocumentsNalRashod].each do |document|
      can :read, document
    end
  end

  def manager
    # Менеджеры: Создают мероприятия,
    # добавляют в интерфейс все платежные документы.
    # Работают с курьерами, клиентами.

    can :manage, CouriersTask, :user_id => @user[:id]    # Заказ, управление своими курьерами
    can :manage, CouriersCompany # Управление местами доставки для курьеров
    can :manage, CouriersCompanyMember # Управление контактыми лицами в местах доставки для курьеров
    can :manage, Client          # Управление клиентской базой
    can :manage, CompanyMember   # Управление предствителями заказчика
    can :manage, Company         # Управление заказчиками
    can :manage, Event, :user_id => @user[:id]  # Управление своими событиями
    can :access, :manager_reports  # Отчеты менеджера
    can :manage, :company_consumption  #Расходы компании

    #Права на добавление любых документов.


    # ========= ****** =========
    [DocumentsBeznalRashod].each do |document|
      can :read, document, :user_id => @user[:id]
      can :create, document
      can :update, document, :user_id => @user[:id], :state => %w[new for_revision]
      can :remove, document, :user_id => @user[:id], :state => %w[new for_revision]

      can :send_to_sign, document, :state => %w[new for_revision]
      can :update_state, document, :state => %w[new for_revision]
    end

    # ========= ****** =========
    [DocumentsBeznalSchet].each do |document|
      can :read, document, :user_id => @user[:id]
      can :create, document
      can :update, document, :user_id => @user[:id], :state => 'new'
      can :remove, document, :user_id => @user[:id], :state => 'new'
    end


    # ========= ****** =========
    [DocumentsNalPrihod, DocumentsNalRashod].each do |document|
      can :read, document, :user_id => @user[:id]
      can :create, document
      can :update, document, :user_id => @user[:id]
      can :remove, document, :user_id => @user[:id]
    end
  end

  def admin

    can :manage, Event           # Управление событиями

    # ========= ****** =========
    [DocumentsBeznalRashod].each do |document|
      can :read, document
      can :create, document
      can :update, document
      can :remove, document

      can :sign, document, :state => %w(added for_revision)
      can :send_to_sign, document, :state => %w[for_revision new]
      can :send_for_revision, document, :state => %w(added)
      can :pay, document, :state => 'signed'
      can :receive, document, :state => 'paid'
      can :complete, document, :state => 'received'
      can :update_state, document
    end

    # ========= ****** =========
    [DocumentsBeznalSchet].each do |document|
      can :read, document
      can :create, document
      can :update, document
      can :remove, document
      can :update_state, document

      can :add_to_1c, document, :state => 'new'
      can :set_ready_to_post, document, :state => 'added_to_1c'
      can :post, document, :state => 'ready_to_post'
      can :complete, document, :state => 'posted'
    end

    # ========= ****** =========
    [DocumentsNalPrihod, DocumentsNalRashod].each do |document|
      can :read, document
      can :create, document
      can :update, document
      can :remove, document

      can :pay, document, :state => 'new'
      can :update_state, document
    end

    # ========= ****** =========

    can :access, :profitability  # Рентабельность
    can :manage, :company_consumption  #Расходы компании
    can :manage, CouriersTask    # Заказ, управление курьерами
    can :manage, CouriersCompany # Управление местами доставки для курьеров
    can :manage, CouriersCompanyMember # Управление контактыми лицами в местах доставки для курьеров
    can :manage, Client          # Управление клиентской базой
    can :manage, CompanyMember   # Управление предствителями заказчика
    can :manage, Company         # Управление заказчиками

    can :manage, User            # Управление учётными записями/правами
    can :manage, :user_passwords # Изменение паролей пользователей

    can :manage, Role
    #can :manage, :all

    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard              # grant access to the dashboard
  end

end
