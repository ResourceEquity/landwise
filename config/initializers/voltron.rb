Voltron.setup do |config|

  # === Voltron Notify Configuration ===

  # Whether or not to use the ActiveJob queue to handle sending email/sms messages
  # A queue is still only used if configured via config.active_job.queue_adapter
  config.notify.use_queue = true

  # Twilio account id number
  # config.notify.sms_account_sid = ''

  # Twilio authentication token
  # config.notify.sms_auth_token = ''

  # Default from phone number. Must be the number provided by Twilio.
  # Avoid the overhead of pre-formatting the number by entering in the format "+1234567890"
  # config.notify.sms_from = ''

  # Default from email address. If not specified the default from in the mailer or the :from param on mail() is used
  config.notify.email_from = 'LandWise <no-reply@resourceequity.org>'

  # The below 3 options define how email is sent. Each can be overridden within the `notification.email` block
  # by using the corresponding methods: `mailer`, `method`, and `template`
  config.notify.default_mailer = Voltron::NotificationMailer

  # Within the mailer you define when sending a notification, this is the method that will be called
  # So in the default case, `Voltron::NotificationMailer.notify(...)` will be called
  # config.notify.default_method = :notify

  # The default mail view template to use
  # Note that if you decide to use a custom mailer/method, this becomes irrelevant
  # as you'll have the ability to set the template as you see fit within the mailer's method itself
  # config.notify.default_template = 'voltron/notification_mailer/notify.html.erb'

  # === Voltron Flash Configuration ===

  # What http header the flash messages should be added to on ajax responses
  config.flash.header = 'X-Flash'

  # Whether to group flash messages by type, or give each flash message it's own line, complete with close icon
  config.flash.group = true

  # === Voltron Base Configuration ===

  # Whether to enable debug output in the browser console and terminal window
  # config.debug = false

  # The base url of the site. Used by various voltron-* gems to correctly build urls
  # Defaults to Rails.application.config.action_controller.default_url_options[:host], or 'localhost:3000' if not set
  # config.base_url = 'http://localhost:3000'

  # What logger calls to Voltron.log should use
  config.logger = Logger.new(Rails.root.join('log', "#{Rails.env}.log"))

  # Set the log level for JS output in the browser console.
  # Available log levels are: :debug, :info, :warn, :error, :fatal, and :unknown,
  # or each log levels corresponding number, ranging from 0 through 5 respectively.
  # For consistency the available log levels match possible options for rails' +log_level+,
  # but due to limited output options available in the browser console,
  # "error", "fatal", and "unknown" all behave the same way.
  # config.log_level = Rails.application.config.log_level

end
