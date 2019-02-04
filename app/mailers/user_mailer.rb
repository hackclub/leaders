class UserMailer < ApplicationMailer
  def check_in_reminder
    email = params[:user].email || params[:email]
    clubs = [params[:club]] || User.find_by(email: email).clubs

    clubs.each do |club|
      @club = club
      mail to: email, subject: "Check-in w/ #{@club.name} Hack Club on #{Date.today.to_s}"
    end
  end
end
