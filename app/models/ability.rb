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

    [DocumentsBeznalRashod, DocumentsBeznalSchet, DocumentsNalRashod, DocumentsNalPrihod].each do |document|
      can :read, document, :state => %w(added signed for_revision paid not_for_payment)
      can :update, document, :state => %w(added signed for_revision paid)
      can :remove, document, :state => 'not_for_payment'

      can :sign, document, :state => %w(added for_revision)
      can :send_for_revision, document, :state => %w(added)

      can :block_payment, document, :state => %w(added signed for_revision)
      can :update_state, document
    end
  end

  def administrative_director
    # Администратор: следит за курьерами,
    # входящими и исходящими задолжностями.
  end

  def chief_accountant
    # Главный Бухгалтер: видит что создают менеджеры,
    # подтверждает/создает счета,
    # ставит счетам соответствующие статусы.

    [DocumentsBeznalRashod, DocumentsBeznalSchet, DocumentsNalRashod, DocumentsNalPrihod].each do |document|
      can :read, document, :state => %w(paid signed not_for_payment)
      can :update, document, :state => 'signed'
      can :remove, document, :state => 'not_for_payment'

      can :pay, document, :state => 'signed'
      can :update_state, document, :state => 'signed'
    end
  end

  def manager
    # Менеджеры: Создают мероприятия,
    # добавляют в интерфейс все платежные документы.
    # Работают с курьерами, клиентами.

    #Права на добавление любых документов.

    [DocumentsBeznalRashod, DocumentsBeznalSchet, DocumentsNalRashod, DocumentsNalPrihod].each do |document|
      can :read, document, :user_id => @user[:id], :state => %w(new added signed for_revision paid not_for_payment)
      can :create, document
      can :update, document, :user_id => @user[:id], :state => %w(new added for_revision)
      can :remove, document, :user_id => @user[:id], :state =>%w(new added for_revision not_for_payment)

      can :send_to_sign, document, :user_id => @user[:id], :state => 'new'
      can :update_state, document, :user_id => @user[:id], :state => 'new'

    end

    can :manage, Event, :user_id => @user[:id]  # Управление своими событиями
  end

  def admin

    can :manage, Event           # Управление событиями

    #manager
    #chief_accountant
    general_director

    #[DocumentsBeznalRashod, DocumentsBeznalSchet, DocumentsNalRashod, DocumentsNalPrihod].each do |document|
    #  can :manage, document #Все права
    #  can :sign, document
    #  can :block_payment, document
    #  can :pay, document
    #  can :update_state, document
    #end

    can :manage, CouriersTask    # Заказ, управление курьерами
    can :manage, CouriersCompany # Управление местами доставки для курьеров
    can :manage, CouriersCompanyMember # Управление контактыми лицами в местах доставки для курьеров
    can :manage, Client          # Управление клиентской базой
    can :manage, CompanyMember   # Управление предствителями заказчика
    can :manage, Company         # Управление заказчиками
    can :manage, User            # Управление учётными записями/правами

    can :manage, Role
    #can :manage, :all

    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard              # grant access to the dashboard
    can :manage, :user_passwords # Изменение паролей пользователей
  end

end
