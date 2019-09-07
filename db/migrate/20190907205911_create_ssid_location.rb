class CreateSsidLocation < ActiveRecord::Migration[5.2]
  def change
    create_table :ssid_locations do |t|
		t.belongs_to :ssid, index: true
		t.decimal :latitude
		t.decimal :longitude
		t.string :country
		t.string :region
		t.string :housenumber
		t.string :road
		t.string :city
		t.string :postalcode
		t.date :first_seen
		t.date :last_seen
    end
  end
end
