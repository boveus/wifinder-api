class AddManufacturerToDevices < ActiveRecord::Migration[5.2]
  def change
    add_reference :devices, :manufacturer, index: true
  end
end
