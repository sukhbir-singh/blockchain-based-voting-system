require 'bcrypt'

class HomeController < ApplicationController
   skip_before_action :verify_authenticity_token

   def index
      if session[:user_id].blank?
         render template: 'home'
      else
         @user=User.find(session[:user_id]) rescue nil 
         if @user.blank?            
            render template: 'home'  
         else
            render template: 'dashboard'
         end
      end
   end

   def signup
      unless params[:full_name].blank? || params[:email].blank? || params[:adhaar].blank? || params[:area].blank? || params[:dob].blank? || params[:contact].blank? || params[:password].blank?
   
         u= User.new(full_name: params[:full_name], email: params[:email], adhaar: params[:adhaar], area: params[:area], dob: params[:dob], contact: params[:contact], password: params[:password], image: params[:image] )
         
         if u.save
            u = User.where({email: params[:email], adhaar: params[:adhaar]}).first
            session[:user_id] = u.id
            
            @user = u
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
         u = User.where(email: params[:email]).first
         unless u.blank?
            if params[:password] == AES.decrypt(u.password, AES_KEY)
               session[:user_id] = u.id
               @user = u
               render template: 'dashboard'
            else
               render template: 'home'
            end
         else
            render template: 'home'
         end         
      else
         render template: 'home'
      end
   end

end