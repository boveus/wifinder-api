class CreatePackets < ActiveRecord::Migration[5.2]
  def change
    create_table :packets do |t|
      t.date :capturetime
      t.string :source
      t.string :destination
      t.string :protocol
      t.string :info
      t.ssid :varchar
      t.timestamps
    end
  end
end
