class DashboardController < ApplicationController
   skip_before_action :verify_authenticity_token

	def logout
       session[:user_id]=nil 
       render template: 'home'
	end
end
