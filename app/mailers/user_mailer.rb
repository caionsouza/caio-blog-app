class UserMailer < ApplicationMailer
  def confirm_account
    @user = params[:user]
    @url = params[:url]
    @link = "#{@url}/confirm_email/#{@user.token}"
    mail(to: @user.email,
      subject: "Welcome to the Blog")
  end
end
