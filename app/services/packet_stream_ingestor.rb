class PacketStreamIngestor
  def clean_stream_for_packet(stream_row)
    clean_line = stream_row.split("\t")
    if clean_line.length > 4
      clean_line[0] = clean_line[0].to_i
      clean_line.delete_at(3)
      clean_line.delete_at(0)
      return clean_line
    else
      return false
    end
  end

  def create_packet_from_stream(stream_row)
    data_row = clean_stream_for_packet(stream_row)
    if data_row
      ssid = data_row[5]&.split('=').last.strip || nil
      Packet.create(capturetime: data_row[0],
                   source: data_row[1],
                   destination: data_row[2],
                   protocol: data_row[3],
                   info: data_row[5],
                   ssid: ssid
                 )
    end
  end

  def ingest_from_stream(stream_row)
    packet = create_packet_from_stream(stream_row)
    if packet
      device = Device.find_or_create_by(mac_address: packet.source)
      device.activetimes << Activetime.find_or_create_by(time: packet.capturetime)
      if packet.ssid
        device.ssids << Ssid.find_or_create_by(name: packet.ssid)
      end
    end
  end
end
