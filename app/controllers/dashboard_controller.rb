class DashboardController < ApplicationController
   skip_before_action :verify_authenticity_token

	def logout
       session[:current_user]=nil 
       render template: 'home'
	end
end
