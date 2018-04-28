class ProfileController < ApplicationController
   skip_before_action :verify_authenticity_token

   def index
      if session[:user_id].blank?
         render template: 'home'
      else
         render template: 'profile'
      end
   end

end