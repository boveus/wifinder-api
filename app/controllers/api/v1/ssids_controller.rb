class Api::V1::SsidsController < ApplicationController
  def index
    render json: ssids.paginate(page: page)
  end

  def count
    render json: ssids_count
  end

  def show
    render json: ssid
  end

  private

  def page
    params[:page] || 1
  end

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
