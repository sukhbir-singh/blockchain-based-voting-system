Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   get '/' => 'home#index'
   post '/signup' => 'home#signup'
   post '/login' => 'home#login'
end
