class Api::V1::SsidsController < ApplicationController
  def index
    ssids = Ssid.all
    render json: ssids
  end
  
  def show
    ssid = Ssid.find(params[:id])
    render json: ssid
  end
end
