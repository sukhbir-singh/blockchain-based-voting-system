class HomeController < ApplicationController
   skip_before_action :verify_authenticity_token

   def index
      if session[:user_name].blank?
         render template: 'home'
      else
         render template: 'dashboard'
      end
   end

   def signup
      unless params[:full_name].blank? || params[:email].blank? || params[:adhaar].blank? || params[:area].blank? || params[:dob].blank? || params[:contact].blank? || params[:password].blank?
   
         u= User.new(full_name: params[:full_name], email: params[:email], adhaar: params[:adhaar], area: params[:area], dob: params[:dob], contact: params[:contact], password: params[:password], image: params[:image] ).first
         
         if u.save            
            session[:user_name]=u[:full_name]
            session[:adhaar]=u[:adhaar]
            @user = User.new(full_name: session[:user_name], adhaar: session[:adhaar])
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
         u = User.where(email: params[:email], password: params[:password]).first
         unless u.blank?
            session[:user_name]=u[:full_name]
            session[:adhaar]=u[:adhaar]
            @user = User.new(full_name: session[:user_name], adhaar: session[:adhaar])
            render template: 'dashboard'      
         else
            render template: 'home'
         end         
      else
         render template: 'home'
      end
   end

end