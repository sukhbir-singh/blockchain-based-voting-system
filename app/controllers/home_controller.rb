class HomeController < ApplicationController
   skip_before_action :verify_authenticity_token

   def index
      render template: 'home'
   end

   def signup
      unless params[:full_name].blank? || params[:email].blank? || params[:adhaar].blank? || params[:area].blank? || params[:dob].blank? || params[:contact].blank? || params[:password].blank?
         
         u= User.new(full_name: params[:full_name], email: params[:email], adhaar: params[:adhaar], area: params[:area], dob: params[:dob], contact: params[:contact], password: params[:password], image: params[:image] )
         
         if u.save
            render template: 'dashboard'      
         else
            render template: 'home'
         end         
      else
         render template: 'home'
      end
   end

   def login      
      unless params[:email].blank? || params[:password].blank? 
         u = User.where(email: params[:email], password: params[:password])
         if u.count==1
            render template: 'dashboard'      
         else
            render template: 'home'
         end         
      else
         render template: 'home'
      end
   end

end