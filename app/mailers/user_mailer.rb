class UserMailer < ActionMailer::Base
  default from: "info@mwanga.com"
 
  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Welcome to My Awesome Site", template_path: "mailers/users", template_name: "welcome")
  end
  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Welcome to My Awesome Site", template_path: "mailers/users", template_name: "welcome")
  end  
  def activate(user)
    @user = user
    mail(to: user.email, subject: "Your account has been activated", template_path: "mailers/users", template_name: "activation")
  end
  def reactivate(user)
    @user = user
    mail(to: user.email, subject: "Your account has been reactivated", template_path: "mailers/users", template_name: "reactivation")
  end
  def deactivate(user)
    @user = user
    mail(to: user.email, subject: "Your account has been deactivated", template_path: "mailers/users", template_name: "deactivation")
  end
  def unconfirm(user)
    @user = user
    mail(to: user.email, subject: "Please confirm your email address", template_path: "mailers/users", template_name: "unconfirmed")
  end
end
