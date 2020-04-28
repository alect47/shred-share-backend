class Trip < ApplicationRecord

  has_many :seats, dependent: :destroy
  has_many :user_trips, dependent: :destroy
  has_many :users, through: :user_trips


  validates_presence_of :origin, :destination

  #trip needs a date and estimated time leaving range
  # trip should have a instance method for seats_full?

  #pulll in google maps api for trip length estimate and possible gas required
  # maybe add optimization for when to leave based on traffic
end
