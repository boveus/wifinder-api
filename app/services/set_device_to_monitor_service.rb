class SetDeviceToMonitorService
    def self.set(interface=nil)
    	interface ||= YAML.load(File.read('./config/config.yml'))['device']
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
	  unless interface.empty?
	  	`sudo ip link set #{interface} down`
	    `sudo iwconfig #{interface} mode monitor`
	    `sudo ip link set #{interface} up`
	  else
	    "ERROR: No device specified! \n"
	  end
	end
end