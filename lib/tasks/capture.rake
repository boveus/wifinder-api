require './app/services/capture_service'
desc 'start capturing packets (device must be in monitor mode)'
task :capture => :environment do
  verbose = "#{ENV["verbosity"]}".to_s.downcase == 'true'
  CaptureService.capture(verbose)
end
