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

      if @user.blank?
         render template: 'home'   
         return
      end

      if @user.encryption_key.blank? && !params[:key].blank?
         @user.update_attributes(profile_attributes_with_key)         
      else
         @user.update_attributes(profile_attributes)
      end

      redirect_to dashboard_path
   end

   private 

   def profile_attributes
   	  params.permit(:full_name,:email, :adhaar, :area, :dob, :contact)
   end

   def profile_attributes_with_key
        params.permit(:full_name,:email, :adhaar, :area, :dob, :contact).merge(encryption_key: params[:key])
   end

end