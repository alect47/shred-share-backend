class User < ApplicationRecord
#encrypt password
  has_secure_password
  has_many :vehicles, dependent: :destroy
  has_many :user_trips, dependent: :destroy
  has_many :trips, through: :user_trips

  validates_presence_of :email, :name, :password_digest
  validates_uniqueness_of :email

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # validates_presence_of :user_name
  # validates_uniqueness_of :user_name
end
