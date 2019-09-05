class SetDeviceToMonitorService
    def self.set(interface=nil)
    	config_file = YAML.load(File.read('./config/config.yml'))
    	return false if !config_file
    	interface = config_file['device']
    	return false if !interface
    	set_to_monitor(interface)
    	check_device(interface)
	end

	def self.check_device(interface)
		iwconfig = %x[iwconfig #{interface}]
		if iwconfig.include?(interface) && iwconfig.include?("Mode:Monitor") 
			true
		end
	end

	def self.set_to_monitor(interface)
  	  `sudo ip link set #{interface} down`
      `sudo iwconfig #{interface} mode monitor`
      `sudo ip link set #{interface} up`
	end
end