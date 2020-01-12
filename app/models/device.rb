class Device < ApplicationRecord
  scope :more_than_five_ssids, -> { ssid.count > 5 }

  has_many :ssids
  has_and_belongs_to_many :ssids
  has_and_belongs_to_many :people
  has_and_belongs_to_many :activetimes, through: :activetimes_devices

  def active_hours(year=Time.now.year, month=Time.now.month, day=Time.now.day)
    activetimes.unique_hours(year, month, day)
  end

  def active_days(year=Time.now.year, month=Time.now.month)
    activetimes.unique_days(year, month)
  end

  def all_active_hours
    activetimes.map(&:hour)
  end

  # Pending deletion, the data should be transformed on the front end.
  def all_active_hours_for_chart
    all_active_hours.each_with_index.map do |hour, index|
      index == 0 ? comma = '' : comma = ','
      "#{comma}['active', new Date(0,0,0,#{hour},0,0), new Date(0,0,0,#{hour + 1},0,0)]"
    end
  end
end
