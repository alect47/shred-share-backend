class Vehicle < ApplicationRecord

  belongs_to :user
  has_many :vehicles, dependent: :destroy
  
  # has_many :seats, dependent: :destroy
  validates_presence_of :make, :model
end
