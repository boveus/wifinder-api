class CreatePersonDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :person_devices do |t|
      t.belongs_to :person, index: true
      t.belongs_to :device, index: true
      t.timestamps
    end
  end
end
