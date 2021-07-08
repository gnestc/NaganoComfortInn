NaganoComfortInn::Application.routes.draw do
  # default_url_options :host => "localhost:3000"
  root to: 'pages#home'
  post "results", to:'pages#results'
  post "confirmation", to:'pages#confirmation'
  post "confirmed", to:'pages#confirmed'
  post 'search', to:'admin/reservations#search'

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
    resources :reports
    resources :room_services
  end
end
