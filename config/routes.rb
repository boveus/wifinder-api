Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/devices/:id/activetimes', to: "devices#activetimes", as: 'device_activetime'
      get '/devices/:id/ssids', to: "devices#ssids", as: 'device_ssids'
      resources :devices
      resources :ssids
    end
  end
end
