class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => :users_roles
  has_many :events
  has_many :couriers_tasks

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_ids

  validates :name, :presence => true
  validates :name, :uniqueness => true

end
