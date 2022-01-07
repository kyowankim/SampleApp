Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home' 
  get 'static_pages/home'
  get '/help', to: 'static_pages#help', as: :help
  get '/about', to: 'static_pages#about', as: :about
  get '/contact' => 'static_pages#contact', as: :contact  # => and to: are essentially the same syntax
  get '/signup' => 'users#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
