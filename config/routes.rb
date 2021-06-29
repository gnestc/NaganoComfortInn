NaganoComfortInn::Application.routes.draw do
  root to: 'pages#home'
  resources :by_day_of_week_prices
  resources :by_time_of_year_prices
  resources :invoice_details
  resources :invoices
  resources :reports
  resources :room_services

  get 'search', to:'admin/reservations#search'

  get "results", to:'pages#results'
  get "confirmation", to:'pages#confirmation'
  get "confirmed", to:'pages#confirmed'

  namespace :admin do
    resources :room_types
    resources :views
    resources :change_prices, only: [:index]
    resources :rooms
    resources :customers
    resources :reservations
    resources :reservations_rooms
  end
end
