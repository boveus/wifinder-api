class CreateDeviceActivetimes < ActiveRecord::Migration[5.2]
  def change
    create_table :device_activetimes do |t|
      t.belongs_to :device, index: true
      t.belongs_to :activetime, index: true
      t.timestamps
    end
  end
end
