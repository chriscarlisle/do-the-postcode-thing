# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    get "/" => redirect("/admin/serviced_postcodes")
    resources :serviced_postcodes
    resources :serviced_lsoas
  end
  resource :postcode_checks, only: [:create]
  root "home#index"
end
