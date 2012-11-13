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
  end

  def administrative_director
    # Администратор: следит за курьерами,
    # входящими и исходящими задолжностями.
  end

  def chief_accountant
    # Главный Бухгалтер: видит что создают менеджеры,
    # подтверждает/создает счета,
    # ставит счетам соответствующие статусы.
  end

  def manager
    # Менеджеры: Создают мероприятия,
    # добавляют в интерфейс все платежные документы.
    # Работают с курьерами, клиентами.
    can :manage, Event, :user_id => @user[:id]  # Управление событиями
  end

  def admin

    can :manage, CouriersCompany
    can :manage, Client
    can :manage, CompanyMember
    can :manage, Company  # Управление заказчиками
    can :manage, Event    # Управление событиями
    can :manage, User     # Управление учётными записями/правами
    #can :manage, :all

    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard              # grant access to the dashboard
  end

end
