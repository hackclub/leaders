class UserMailerPreview < ActionMailer::Preview
  def check_in
    UserMailer.with(user: User.first, club: Club.first).check_in
  end
end