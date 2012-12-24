# -*- coding: utf-8 -*-

module DocumentStatesModule

  def self.included(base)
    base.state_machine :state, :initial => :new do

      state :new

      state :added  # Добавлено. Добавляет менеджер, он же может редактировать/удалить.

      #Далее, документ будет доступен для действия и Ген Диру. Он может его либо принять, либо отправить на доработку.

      state :signed #Подписано: Ставит гендир. Менеджер после установки статуса не может редактировать/удалить.

      state :for_revision  #На доработку: Гендир может внести примечание, почему документ не принят

      # После принятия документа, документ доступен для бухгалтера. Он может его оплатить и вненсти соответствующие данные.

      state :paid #Оплачено: Выставляет Бухгалтер. Так-же вносится доп инфа типа пнформация по расходу.

      #Гендир может поставить статус:
      #Запрещено к оплате. Гендир также может добавить примечание. Со счетом делать ничего нельзя, но может удалить каждый
      state :not_for_payment

      state :deleted

      event :send_to_sign do # w/o state_note
        transition :new => :added
      end

      event :sign do # w/o state_note
        transition [:added, :for_revision] => :signed
      end

      event :send_for_revision do # with state_note
        transition [:added] => :for_revision
      end

      event :pay do # w/o state_note
        transition :signed => :paid
      end

      event :block_payment do  # with state_note
        transition all - [:new, :paid] => :not_for_payment
      end

      event :remove do
        transition all => :deleted
      end

    end
  end

=begin Такую штуку написал, но похоже - зря =(

  roles_read_ability = [
    :admin => '',
    :manager => '',
    :general_director => '',
    :chief_accountant => ''
  ]

  roles_read_ability.each do |role, conditions|
    method_name = ("accessible_to_" + role.to_s).to_sym
    send :define_method, method_name do
      send :where, conditions
    end
  end

=end

end
