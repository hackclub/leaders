class UserMailer < ApplicationMailer
  def check_in_reminder
    email = params[:user].email || params[:email]
    mail to: email, subject: "Club check-in link"
  end
end
