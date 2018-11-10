class ApplicationMailer < ActionMailer::Base
  default from: 'Hack Club Team <team@hackclub.com>'
  layout 'mailer'

  # allow usage of application helper
  helper :application
end
