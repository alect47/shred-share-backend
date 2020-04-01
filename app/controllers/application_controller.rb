class ApplicationController < ActionController::Base

  #might want to remove line 4
  protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token

  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!

  def json_parse(json)
    JSON.parse(json.body.read, symbolize_names: true, quirks_mode: true)
  end
  
  def login!
    session[:user_id] = @user.id
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorized_user?
     @user == current_user
  end

   def logout!
     session.clear
   end
end
