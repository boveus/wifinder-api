class Ssid < ApplicationRecord
  has_and_belongs_to_many :devices
  has_many :ssid_locations

  def self.unique
  	distinct(:name)
  end
end
