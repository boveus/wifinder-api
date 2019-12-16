class RemoveManufacturerFromDevices < ActiveRecord::Migration[5.2]
  def change
    remove_reference :devices, :manufacturer, index: true
  end
end
