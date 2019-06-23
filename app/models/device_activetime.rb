class DeviceActivetime < ApplicationRecord
    has_and_belongs_to_many :devices
    has_and_belongs_to_many :active_times
end
