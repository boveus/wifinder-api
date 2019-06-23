class CreateActivetimesDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :activetimes_devices do |t|
      t.belongs_to :device, index: true
      t.belongs_to :activetime, index: true
      t.timestamps
    end
  end
end
