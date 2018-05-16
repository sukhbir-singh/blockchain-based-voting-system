Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   get '/' => 'home#index'
   get '/dashboard' => 'home#index'
   get '/home' => 'home#index'
   get '/signup' => 'home#index'
   get '/login' => 'home#index'
   get '/logout' => 'home#index'
   get '/profile' => 'profile#index'

   get '/all_votes' => 'dashboard#get_valid_votes'
   
   get '/vote' => 'vote#index'
   post '/vote' => 'vote#submit_vote'
   post 'update_vote_status' => 'vote#change_status'

   get '/last_vote_info' => 'vote#get_voter_information'
   
   post '/signup' => 'home#signup'
   post '/login' => 'home#login'
   post '/logout' => 'dashboard#logout'

   post '/profile' => 'profile#update_profile'
end
