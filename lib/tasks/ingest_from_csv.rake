require 'task_helpers/packet_ingestor'

desc 'Populate the DB with CSVs from the data directory'
task :csv_ingest do
  if File.exist?('./db/wifinder.db')
    PacketIngestor.new.ingest
    puts "There are now #{Device.count} unique MAC addresses #{Packet.count} Packets"
    puts "and #{Ssid.count} unique SSIDs in the database"
  else
    puts "ERROR: There is no database!"
  end
end
