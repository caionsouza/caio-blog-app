class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user! 
  before_action :user_has_profile?
  allow_browser versions: :modern
  helper_method :current_user

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  private 

  def authenticate_user!
    redirect_to login_path, notice: 'You have to be logged in.' unless current_user
  end

  def user_has_profile?
    if current_user && current_user.profile.nil?
      redirect_to new_profile_path, notice: 'Tell us more about you'
    end 
  end

  def user_is_member?
    if current_user && current_user.profile.member?
      redirect_to root_path, notice: "You don't have permission"
    end
  end
end
