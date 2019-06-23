Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :devices
      resources :ssids
    end
  end
end
