class CreateManufacturers < ActiveRecord::Migration[5.2]
  def change
    create_table :manufacturers do |t|
      t.string :organization
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :country

      t.timestamps
    end
  end
end
