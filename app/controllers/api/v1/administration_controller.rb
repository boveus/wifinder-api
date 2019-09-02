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

  def set_capture_device_to_monitor
    if set_device_to_monitor
      render status: 200, json: {message: "Successfully set #{get_capture_device} to monitor mode"}
    else
      render status: 500, json: {message: "error"}
    end
  end

  def start_capture
    if get_capture_device
      job = run_capture_task
      render status: 200, json: {
        message: "Sucessfully started capturing on #{get_capture_device}",
        job_id: "#{job.job_id}"}
    else
      render status: 500, json: {message: "error"}
    end
  end

  def check_status
    if get_status
      render status: 204
    else
      render status: 200
    end
  end

  def available_devices
    render json: {body: ShowWirelessInfoService.run_iwconfig}
  end

  private

  def get_status
    if interface_params
      CaptureService.no_packets?(interface_params)
    else
      CaptureService.no_packets?
    end
  end

  def run_capture_task
    StartCaptureJob.perform_later
  end

  def set_device_to_monitor
     SetDeviceToMonitorService.set
  end

  def interface_params
    params[:device_id]
  end

  def status_params
    params[:interval]
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
