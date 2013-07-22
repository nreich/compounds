class User < ActiveRecord::Base
  rolify
  has_many :transactions
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  validates :name, presence: true, length: { maximum: 50,
            too_long: "%{count} characters is the maximum allowed" }
  before_create :add_default_role

private
  def add_default_role
    self.add_role :user
  end

end
