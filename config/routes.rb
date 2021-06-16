NaganoComfortInn::Application.routes.draw do
  root to: 'pages#home'
  get 'about', to:'pages#about'
  resources :by_day_of_week_prices
  resources :by_time_of_year_prices
  resources :customers
  resources :invoice_details
  resources :invoices
  resources :reports
  resources :reservations
  resources :reservations_rooms
  resources :room_services
  resources :room_types
  resources :rooms
  resources :views
end
