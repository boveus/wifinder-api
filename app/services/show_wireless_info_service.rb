class ShowWirelessInfoService
	def self.run_iwconfig
		%x[iwconfig]
	end
end