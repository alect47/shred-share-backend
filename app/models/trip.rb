class Trip < ApplicationRecord

  has_many :seats, dependent: :destroy
  has_many :user_trips, dependent: :destroy
  has_many :users, through: :user_trips


  validates_presence_of :origin, :destination

end
