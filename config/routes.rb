Rails.application.routes.draw do
  resource :postcode_checks, only: [:create]
  root "home#index"
end
