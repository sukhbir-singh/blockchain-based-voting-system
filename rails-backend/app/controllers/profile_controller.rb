class ProfileController < ApplicationController
   skip_before_action :verify_authenticity_token

   def index
      if session[:user_id].blank?
         render template: 'home'
      else
      	@user=User.find(session[:user_id]) rescue nil 
         if @user.blank?            
            render template: 'home'  
         else
            render template: 'profile'
         end         
      end
   end

   def update_profile   
   		@user=User.find(session[:user_id])
   		@user.update_attributes(profile_attributes)

      #    u= User.new(full_name: params[:full_name], email: params[:email], adhaar: params[:adhaar], area: params[:area], dob: params[:dob], contact: params[:contact], password: BCrypt::Password.create(params[:password]), image: params[:image] )
         
      #    if u.save
      #       # u = User.where({email: params[:email], adhaar: params[:adhaar], email: params[:email]}).first
      #       session[:user_id] = u.id
            
      #       @user = u
      #       render template: 'dashboard'
      #    else
      #       render template: 'home'
      #    end         
      # else
      #    render template: 'home'
      # end

   end

   private 

   def profile_attributes
   	  params.permit(:full_name,:email, :adhaar, :area, :dob, :contact)
   end

end