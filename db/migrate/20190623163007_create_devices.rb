class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :mac_address
      t.timestamps
    end
  end
end
