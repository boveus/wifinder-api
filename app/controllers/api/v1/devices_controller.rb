class Api::V1::DevicesController < ApplicationController
  def index
    render json: devices
  end

  def show
    render json: device
  end

  def ssids
    render json: device.ssids
  end

  def activetimes
    render json: device.activetimes
  end

  private

  def devices
    Device.all
  end

  def device
    Device.find(params[:id])
  end
end
