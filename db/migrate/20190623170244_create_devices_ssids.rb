class CreateDevicesSsids < ActiveRecord::Migration[5.2]
  def change
    create_table :devices_ssids do |t|
      t.belongs_to :device, index: true
      t.belongs_to :ssid, index: true
      t.timestamps
    end
  end
end
