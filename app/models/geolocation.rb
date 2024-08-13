class Geolocation < ApplicationRecord

  validates :ip, uniqueness: true

end
