class Api::V1::DevicesController < ApplicationController
  def index
    render json: devices
  end

  def count
    render json: devices_count
  end

  def show
    render json: device
  end

  def ssids
    render json: device.ssids.unique
  end

  def activetimes
    render json: device.activetimes
  end

  private

  def devices_count
    Device.count
  end

  def devices
    Device.all
  end

  def device
    id = params[:id] || params[:device_id]
    Device.find(id)
  end
end
