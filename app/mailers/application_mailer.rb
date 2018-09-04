class ApplicationMailer < ActionMailer::Base
  default from: 'Hack Club Leaders <leaders@hackclub.com>'
  layout 'mailer'

  # allow usage of application helper
  helper :application
end
