class Activetime < ApplicationRecord
  has_and_belongs_to_many :devices_activetimes
end
