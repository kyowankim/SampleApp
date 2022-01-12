Rails.application.routes.draw do
  get 'session/new'
  
  root 'static_pages#home' 
  get 'static_pages/home'
  get '/help', to: 'static_pages#help', as: :help
  get '/about', to: 'static_pages#about', as: :about
  get '/contact' => 'static_pages#contact', as: :contact  # => and to: are essentially the same syntax
  get '/signup' => 'users#new'
  get '/login' => "session#new" 
  post '/login' => "session#create"
  delete '/logout' => "session#delete"
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
