module SmtpURL
  class Railtie < Rails::Railtie
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = SmtpURL::Parser.new(ENV["SMTP_URL"]).parse
  end
end
