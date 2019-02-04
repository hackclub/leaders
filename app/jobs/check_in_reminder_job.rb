class CheckInReminderJob < ApplicationJob
  queue_as :default

  def perform(repeat = false)
    self.class.set(wait: 1.day).perform_later(true) if repeat

    Club.select{ |club| club.meeting_day == Date.today.wday }.each do |club|
      # clubs can have nil leaders, so we need to remove them from our list
      users = club.users.compact
      users.each{ |user| notify(user, club) if (user.email_on_check_in?) }
    end
  end

  def notify(user, club)
    UserMailer.with(user: user, club: club).check_in_reminder.deliver_later
  end
end
