Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # get '/devices/:id/activetimes', to: "devices#activetimes", as: 'device_activetime'
      # get '/devices/:id/ssids', to: "devices#ssids", as: 'device_ssids'
      resources :devices do
        get '/activetimes', to: "devices#activetimes"
        get "/ssids", to: "devices#ssids"
      end
      resources :ssids
      resources :people
      get '/administration/capture_device', to: "administration#capture_device"
      get '/administration/set_capture_device/:device_id', to: "administration#set_capture_device"
      get '/administration/start_capture', to: "administration#start_capture"
      get '/administration/check_status(/:interval)', to: "administration#check_status"
    end
  end
end
