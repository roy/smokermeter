namespace :api do
  namespace :v1 do
    resources :registrations, only: [:create]
    resources :barbecues do
      resources :thermometers
    end
  end
end
