class Trip < ApplicationRecord

  validates_presence_of :origin, :destination

end
