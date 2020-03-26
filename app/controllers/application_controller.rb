class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token

  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!

  def login!
    session[:user_id] = @user.id
  end
  
end
