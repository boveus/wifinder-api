class Activetime < ApplicationRecord
  has_and_belongs_to_many :devices, through: :activetimes_devices
  
  def time=(time)
    write_attribute(:time, time.beginning_of_hour)
  end

  def hour
    time.hour
  end

  def day
    time.day
  end

  def self.unique_hours(year, month, day)
    day = Date.new(year, month, day).all_day
    where(time: day)
    .map(&:hour)
  end

  def self.unique_days(year, month)
    month = Date.new(year, month).all_month
    where(time: month)
    .map(&:day)
  end
end
