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
         new_vote = Vote.where({generated_id: params[:generated_id]}).first rescue nil
         old_vote = Vote.where({generated_id: params[:old_generated_id]}).first rescue nil

         if new_vote.update_attributes({ is_valid: true }) 
            old_vote.update_attributes({ is_valid: false }) unless old_vote.blank?
            render json: {message: 'vote status updated in db', success: true}
         else
            render json: {message: 'vote status change failed', success: false}
         end
         return
      end

      render json: {message: 'some error occured', success: false}
   end

   def get_voter_information
      vote = Vote.where({generated_id: params[:generated_id]}).first
      leader = Leader.where({id: vote.leader_id}).first  rescue nil

      if vote.blank?
         render json: {message: 'invalid generated_id passed', success: false}
         return
      end

      if leader.blank?
         json = vote.as_json(:only => [:generated_id, :created_at, :is_valid]).merge(leader_name: '', party_name: '')
      else
         json = vote.as_json(:only => [:generated_id, :created_at, :is_valid]).merge(leader_name: leader.name, party_name: leader.party )
      end

      render json: json
   end

   private 

   def vote_attributes_with_key
        params.permit(:leader_id, :encryption_key)
   end

end