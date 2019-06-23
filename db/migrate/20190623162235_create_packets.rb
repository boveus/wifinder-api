class CreatePackets < ActiveRecord::Migration[5.2]
  def change
    create_table :packets do |t|
      t.datetime :capturetime
      t.string :source
      t.string :destination
      t.string :protocol
      t.string :info
      t.string :ssid
      t.timestamps
    end
  end
end
