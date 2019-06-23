class Api::V1::DevicesController < ApplicationController
  def index
    devices = Device.all
    render json: devices
  end

  def show
    device = Device.find(params[:id])
    render json: device
  end
end
