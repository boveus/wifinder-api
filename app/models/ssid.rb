class Ssid < ApplicationRecord
  has_and_belongs_to_many :devices

  def self.unique
  	distinct(:name)
  end
end
