class ApplicationMailer < ActionMailer::Base

  helper Rails.application.routes.url_helpers

  default from: 'LandWise <no-reply@resourceequity.org>'

  layout 'mailer'

end
