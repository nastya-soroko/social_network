class UserMailer < ActionMailer::Base
  default :from=> "soroko_a1@gmail.com"
  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/users/#{@user.id}"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
