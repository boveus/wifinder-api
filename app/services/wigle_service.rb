module WigleService
	extend self
	def header
		wigle_token = YAML.load(File.read('./config/config.yml'))['wigle_token']
		{Authorization: "Basic #{wigle_token}"}
	end

	def base_url
		"https://api.wigle.net/api/v2/"
	end

	def network_search_url
		"#{base_url}network/search"
	end

	def test
	end

	def get_ssid_info(ssid)
		Faraday.get(network_search_url, 
			{onlymine: false, 
			 first: 0, 
			 freenet: false, 
			 paynet: false, 
			 ssid: ssid}, header)
	end

	def create_ssid_location_from_wiggle(result)
		SsidLocation.find_or_create_by(
			latitude: result["trilat"],
			longitude: result["trilong"],
			country: result["country"],
			region: result["region"],
			housenumber: result["housenumber"],
			road: result["road"],
			city: result["city"],
			postalcode: result["postalcode"],
			first_seen: Date.parse(result["firsttime"]),
			last_seen: Date.parse(result["lasttime"])
			)
	end

	def lat_longs_for_ssid(ssid)
		response = get_ssid_info(ssid)
		if response.status == 200
			ssid = Ssid.find_by(name: ssid)
			JSON.parse(response.body)["results"].each do |result|
				ssid.ssid_locations << create_ssid_location_from_wiggle(result)
			end
		end
	end
end