class UserMailer < ApplicationMailer
  def check_in_reminder
    email = params[:user].email || params[:email]
    clubs = [params[:club]] || User.find_by(email: email).clubs

    clubs.each do |club|
      @club = club
      mail to: email, subject: "#{Date.today.to_s} #{@club.name} Hack Club check-in link"
    end
  end
end
