class CheckInReminderJob < ApplicationJob
  queue_as :default

  def perform(repeat = false)
    self.class.set(wait: 1.day).perform_later(true) if repeat

    Club.select{ |club| club.meeting_day == Date.today.wday }.each do |club|
      club.users.each{ |user| notify user if (user.email_on_check_in?) }
    end
  end

  def notify(user)
    UserMailer.with(user: user).check_in_reminder.deliver_later
  end
end
