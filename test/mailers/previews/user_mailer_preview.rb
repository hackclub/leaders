class UserMailerPreview < ActionMailer::Preview
  def check_in_reminder
    UserMailer.with(user: User.first).check_in_reminder
  end
end