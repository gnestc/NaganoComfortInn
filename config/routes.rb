NaganoComfortInn::Application.routes.draw do
  root to: 'pages#home'
  get "results", to:'pages#results'
  get "confirmation", to:'pages#confirmation'
  post "confirmed", to:'pages#confirmed'

  resources :reports
  resources :room_services

  get 'search', to:'admin/reservations#search'

  namespace :admin do
    resources :room_types
    resources :views
    resources :change_prices, only: [:index]
    resources :rooms
    resources :customers
    resources :reservations
    resources :by_day_of_week_prices
    resources :by_time_of_year_prices
    resources :invoices
  end
end
