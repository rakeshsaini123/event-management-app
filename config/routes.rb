Rails.application.routes.draw do
  resources :events
  resources :tickets
  resources :bookings
end
