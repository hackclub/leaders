class CheckInReminderJob < ApplicationJob
  queue_as :default

  def perform(repeat = false)
    self.class.set(wait: 1.week).perform_later(true) if repeat

    User.all.each{ |user| notify user if user.email_on_check_in? }
  end

  def notify(user)
    UserMailer.with(user: user).check_in_reminder.deliver_later
  end
end
