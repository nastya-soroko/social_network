require "base64"
class UserMailer < ActionMailer::Base
  default :from=> "soroko_a1@gmail.com"
  def welcome_email(user)
    @user = user
		@id=Base64.encode64(@user.id.to_s)
    @url =  "http://localhost:3000/activate/#{Base64.encode64(@user.id.to_s)}"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
