class UserMailer < ApplicationMailer
  def check_in_reminder
    email = params[:user].email || params[:email]
    clubs = User.find_by(email: email).clubs

    clubs.each do |club|
      @club = club
      mail to: email, subject: "Club check-in link"
    end
  end
end
