class StartCaptureJob < ApplicationJob
  queue_as :default

  def perform(*args)
    CaptureService.capture
  end
end
