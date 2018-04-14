class DashboardController < ApplicationController
   skip_before_action :verify_authenticity_token

	def logout
       session[:user_name]=nil 
       session[:adhaar]=nil 
       render template: 'home'
	end
end
