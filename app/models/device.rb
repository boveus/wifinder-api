class Device < ApplicationRecord
  scope :more_than_five_ssids, -> { ssid.count > 5 }

  has_many :ssids
  has_and_belongs_to_many :ssids
  has_and_belongs_to_many :people
  has_and_belongs_to_many :activetimes

  def active_hours(day=Time.now.day, month=Time.now.month)
    Device.db.execute("SELECT DISTINCT hour from
    activetimes where deviceid = (?) AND day = (?) AND month = (?)", [id, day, month])
  end

  def all_active_hours
    Device.db.execute("SELECT DISTINCT hour from
    activetimes where deviceid = (?)", id)
  end

  def all_active_hours_for_chart
    all_active_hours.each_with_index.map do |hour, index|
      index == 0 ? comma = '' : comma = ','
      "#{comma}['active', new Date(0,0,0,#{hour.first},0,0), new Date(0,0,0,#{hour.first + 1},0,0)]"
    end
  end

  def active_days(month=Time.now.month)
    Device.db.execute("SELECT DISTINCT day from
    activetimes where deviceid = (?) AND month = (?)", [id, month]).first
  end


end
