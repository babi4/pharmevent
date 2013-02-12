class DocumentsNalPrihod < ActiveRecord::Base

  default_scope where { state != 'deleted' }
  scope :uncompleted, where { state << %w(paid deleted) }
  scope :completed,   where(:state => 'paid')

  attr_accessible :state_note, :state, :company, :date, :description, :name, :summ, :telephone, :user_id, :event_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, :company, :summ, :presence => true

  state_machine :state, :initial => :new do

    state :new
    state :paid
    state :deleted

    event :pay do
      transition :new => :paid
    end

    event :remove do
      transition all => :deleted
    end
  end

  def self.search(params = {})
    if params[:act_num].blank? && params[:act_date].blank? && params[:fact_num].blank? && params[:fact_date].blank?
      unless params[:schet_num].blank? && params[:schet_date].blank? && params[:schet_sum].blank? && params[:state].blank?
        result = self.scoped
        unless params[:state].blank?
          params[:state] = 'paid' if params[:state] == 'completed'
          result = result.where(:state => params[:state])
        end
        result = result.where(:description => params[:schet_num])       unless params[:schet_num].blank?
        result = result.where(:date => Date.parse(params[:schet_date])) unless params[:schet_date].blank?
        result = result.where(:summ => params[:schet_sum])              unless params[:schet_sum].blank?
        result.includes(:event)
      end
    end
  end

end
