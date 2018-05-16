class DashboardController < ApplicationController
   skip_before_action :verify_authenticity_token

	def logout
       session[:user_id]=nil 
       render template: 'home'
	end

	def get_valid_votes
		vote_ids = Vote.where({is_valid: true}).only(:leader_id)
		leader_ids = vote_ids.map {|vote| Leader.find(vote.leader_id).id.to_s rescue 'null'}			

		party = {}
		leader_name = {}

		leader_ids.each do |l_id|
			leader = Leader.find(l_id) rescue nil
			next if leader.blank?

			if party[leader.party].blank?
				party[leader.party] = 1
			else
				party[leader.party] = party[leader.party] + 1
			end

			key = leader.name + " (" + leader.party + ")"

			if leader_name[key].blank?
				leader_name[key] = 1
			else
				leader_name[key] = leader_name[key] + 1
			end
		end

		formatted_leader_names = leader_name.keys
		formatted_counts = leader_name.values
		formatted_party_names = party.keys
		formatted_party_counts = party.values

		render json: {"success": true, "data": {
				leader_names: leader_name, party: party
			}, "graph_data": { leaders: formatted_leader_names, leader_counts: formatted_counts, 
				party: formatted_party_names, party_counts: formatted_counts } }
	end
end
