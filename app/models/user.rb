class User < ActiveRecord::Base
  acts_as_paranoid

  has_and_belongs_to_many :roles, :join_table => :users_roles
  has_many :events
  has_many :couriers_tasks
  has_many :documents_beznal_rashods
  has_many :documents_beznal_schets
  has_many :documents_nal_rashods
  has_many :documents_nal_prihods

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :first_name, :last_name, :middle_name ,:salary ,:percent, :email, :password, :password_confirmation, :remember_me, :role_ids

  validates :first_name, :last_name, :presence => true

  before_destroy :clear_email


  def name
    middle_name_str = middle_name ? "#{middle_name} " : ''
    "#{first_name} #{middle_name_str}#{last_name}"
  end

  def clear_email
    self.email = "deleted_at_#{Time.now.to_i} #{self.email}"
    self.save
  end

  def bonus(profit_total)
    if self.salary && self.percent
      ((profit_total - self.salary) * self.percent / 100).round(2)
    else
      0
    end
  end

end
