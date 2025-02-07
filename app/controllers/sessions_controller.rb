class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[login create]
  skip_before_action :user_has_profile?

  def login
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.present? && @user.authenticate(params[:user][:password])
      if @user.is_confirmed?
      
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Log in successfully'
      else
        UserMailer.with(user: @user).confirm_account.deliver_later
        redirect_to login_path, notice: 'An email was sent to your email account'
      end
    else
      redirect_to login_path, notice: "Email or password incorrect"
    end
  end

  def destroy 
    session[:user_id] = nil 
    redirect_to login_path, notice: "Logout successfully" 
  end
end
