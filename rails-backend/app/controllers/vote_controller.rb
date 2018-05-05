class VoteController < ApplicationController
   skip_before_action :verify_authenticity_token

   def index
      if session[:user_id].blank?         
         render template: 'home'
      else
      	@user=User.find(session[:user_id]) rescue nil 
         if @user.blank?            
            render template: 'home'  
         else
            @leaders = Leader.all
            render template: 'voting'
         end         
      end
   end

   def vote
		
   end

   private 

   def vote_attributes_with_key
        params.permit(:leader_id, :adhaar).merge(encryption_key: params[:key])
   end

end