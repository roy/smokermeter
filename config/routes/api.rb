namespace :api do
  namespace :v1 do
    resources :registrations, only: [:create]
  end
end
