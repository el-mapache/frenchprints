class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :email, presence: true, 
            format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]+\z/i,
                      message: "Invalid email format" }
  validates :password, presence: true, confirmation: true

  # Not sure why this isnt in the database
  after_create lambda { |user| user.update_attribute(:admin, true) }

  def is_admin?
    admin
  end
end
