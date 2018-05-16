class DashboardController < ApplicationController
   skip_before_action :verify_authenticity_token

	def logout
       session[:user_id]=nil 
       render template: 'home'
	end

	def get_valid_votes
		vote_ids = Vote.where({is_valid: true}).only(:leader_id)
		leader_ids = vote_ids.map {|vote| Leader.find(vote.leader_id).id.to_s rescue 'null'}			
		leaders = Leader.where(:_id.in => leader_ids).all

		output = []

		leaders.each do |leader|
			obj = {name: leader.name, id: leader.id.to_s, party: leader.party}
			output.push(obj)
		end

		render json: {"success": true, data: output}
	end
end
