class Api::V1::AdministrationController < ApplicationController
  def capture_device
    render json: {device: get_capture_device}
  end

  def set_capture_device
    if set_yml_capture_device(interface_params)
      render status: 200, json: {message: "Sucessfully set interface to #{interface_params}"}
    else
      render status: 500, json: {message: "error"}
    end
  end

  def start_capture
    if get_capture_device
      run_capture_task
      render status: 200, json: {message: "Sucessfully started capturing on #{interface_params}"}
    else
      render status: 500, json: {message: "error"}
    end
  end

  private

  def run_capture_task
    CaptureService.capture
  end

  def interface_params
    params[:device_id]
  end

  def set_yml_capture_device(interface)
    if File.write("config/config.yml", {'device' => interface}.to_yaml)
      interface
    else
      false
    end
  end

  def get_capture_device
    YAML.load(File.read('./config/config.yml'))['device']
  end
end
