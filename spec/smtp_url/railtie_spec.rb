require 'spec_helper'

module Rails
  class Railtie
    def self.config
      Config.new
    end

    def self.mailer_config
      MailerConfig.new
    end
  end

  class Config
    def action_mailer
      MailerConfig.new
    end
  end

  class MailerConfig
    def deliver_method=(method)
    end

    def smtp_settings=(hash)
    end
  end

  class Logger
    def warn(message)
    end
  end

  def self.logger
    Logger.new
  end
end

require 'smtp_url/railtie'

describe SmtpURL::Railtie do

  it "should log a warning if SMTP_URL is not set" do
    Rails::Logger.any_instance.should_receive(:warn).with('SmtpURL did not setup your email delivery because the SMTP_URL env var was missing')
    load 'smtp_url/railtie.rb'
  end

  it "should setup action_mailer settings when SMTP_URL is set" do
    ENV['SMTP_URL'] = 'smtp://localhost:1025'
    Rails::MailerConfig.any_instance.should_receive(:delivery_method=).with(:smtp)
    Rails::MailerConfig.any_instance.should_receive(:smtp_settings=)
    load 'smtp_url/railtie.rb'
  end
end





