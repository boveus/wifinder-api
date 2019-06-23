class CreateDevicesssids < ActiveRecord::Migration[5.2]
  def change
    create_table :devicessids do |t|
      t.belongs_to :device, index: true
      t.belongs_to :ssid, index: true
      t.timestamps
    end
  end
end
