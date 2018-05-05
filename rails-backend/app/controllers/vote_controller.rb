class VoteController < ApplicationController
   skip_before_action :verify_authenticity_token

   def index
      # redirect_to dashboard_path

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

   def submit_vote
      @user=User.find(session[:user_id])

      if @user.encryption_key == params[:encryption_key]
         v = Vote.new
         v.leader_id = params[:leader_id]
         v.generated_id = SecureRandom.base64    

         if v.save
            @user.update_attributes({last_voted_at:Time.now})

            # To-Return: user_id, link, hash, encryption_key_hash
            render json: {message: 'vote saved in db partially', success: true, 
               data: {link: v.generated_id, hash: v.calculate_hash, 
                  encryption_key: params[:encryption_key] }}

         else
            render json: {message: 'some error occured while saving vote in db', success: false}

         end         
      else
         render json: {message: 'encryption_key entered is invalid', success: false}

      end
   end

   def change_status
      @user=User.find(session[:user_id])

      unless @user.blank? 
         vote = Vote.where({generated_id: params[:generated_id]}).first
         if vote.update_attributes({ is_valid: true })
            render json: {message: 'vote status updated in db', success: true}
         else
            render json: {message: 'vote status change failed', success: false}
         end
         return
      end

      render json: {message: 'some error occured', success: false}
   end

   private 

   def vote_attributes_with_key
        params.permit(:leader_id, :encryption_key)
   end

end