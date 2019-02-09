class UserMailer < ApplicationMailer
  def check_in
    email = params[:user].email || params[:email]
    clubs = [params[:club]] || User.find_by(email: email).clubs

    clubs.each do |club|
      @club = club
      mail to: email,
           bcc: 'max@hackclub.com',
           reply_to: 'checkin@hackclub.com',
           subject: "Check-in w/ #{@club.name} Hack Club on #{Date.today.to_s}"
    end
  end
end
