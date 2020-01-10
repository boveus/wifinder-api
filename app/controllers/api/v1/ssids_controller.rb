class Api::V1::SsidsController < ApplicationController
  def index
    render json: ssids
  end

  def count
    render json: ssids_count
  end

  def show
    render json: ssid
  end

  private

  def ssids_count
    Ssid.count
  end

  def ssids
    Ssid.all
  end

  def ssid
    id = params[:id]
    Ssid.find(id)
  end
end
