require "smtp_url/parser"

module SmtpURL
  class Railtie < Rails::Railtie
    if ENV["SMTP_URL"]
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = SmtpURL::Parser.new(ENV["SMTP_URL"]).parse
    else
      Rails.logger.warn "SmtpURL did not setup your email delivery because the SMTP_URL env var was missing"
    end
  end
end
