class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user

  def set_user  	
  	unless session[:user_name].blank?
  		@user = User.new(full_name: session[:user_name], adhaar: session[:adhaar])
  	end
  end
end
