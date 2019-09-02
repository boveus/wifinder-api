require './app/services/set_device_to_monitor_service'
desc 'Usage: interface=wlan1 rake set_to_monitor | set the device to monitor mode'
task :set_to_monitor do
  specified_interface = ENV["interface"]
  if SetDeviceToMonitorService.set(specified_interface)
    printf "Success\n"
  end
end
