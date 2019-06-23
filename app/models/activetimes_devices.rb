class ActivetimesDevices < ApplicationRecord
    has_and_belongs_to_many :devices
    has_and_belongs_to_many :activetimes
end
