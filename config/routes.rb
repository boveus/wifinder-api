Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "devices/count", to: 'devices#count'
      resources :devices do
        get '/activetimes', action: "activetimes"
        get "/ssids", action: "ssids"
      end
      resources :ssids
      resources :people
      namespace :administration do
        get '/set_capture_device_to_monitor', action: "set_capture_device_to_monitor"
        get '/capture_device', action: "capture_device"
        get '/set_capture_device/:device_id', action: "set_capture_device"
        get '/start_capture', action: "start_capture"
        get '/check_status(/:interval)', action: "check_status"
        get '/available_devices', action: "available_devices"
      end
    end
  end
end
