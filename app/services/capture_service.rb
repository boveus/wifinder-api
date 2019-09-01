require 'pty'
class CaptureService
  def self.no_packets?(seconds = 60)
    (Time.now - seconds) > Packet.newest.created_at
  end

  def self.capture
    begin
      psi = PacketStreamIngestor.new
      PTY.spawn( cmd ) do |stdout, stdin, pid|
        begin
          stdout.each do |line|
            psi.ingest_from_stream(line)
          end
        rescue Errno::EIO
          return "I tried to capture using the device #{interface}.  Is this correct?\n
          ERROR: Perhaps you didnt create the database or you didnt set your interface to monitor mode?
          You may need to allow non-sudo users to capture packets using tshark.
          See: https://osqa-ask.wireshark.org/questions/7976/wireshark-setup-linux-for-nonroot-user"
        end
      end
    rescue PTY::ChildExited
      puts "The child process exited!"
    end
  end

  def self.interface
    YAML.load(File.read('./config/config.yml'))['device']
  end

  def self.cmd
    "tshark -i #{interface} -f 'subtype probereq' -t ad -T tabs -o nameres.mac_name:FALSE"
    # -f specifies it to only capture using the specified filter (probe requests)
    # -t ad specifies to use the absolute time with a date added
    # -T tabs specifies the format of the output
    # -o nameres.mac_name:FALSE is to disable the vendor OUI lookup, so we receive a valid MAC
    # https://www.wireshark.org/docs/wsug_html_chunked/ChCustCommandLine.html
  end
end
