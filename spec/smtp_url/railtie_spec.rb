require 'spec_helper'
require 'smtp_url/railtie'

module Rails
  class << self
    attr_accessor :logger
  end
end

describe SmtpURL::Railtie do
  before do
    Rails::Railtie::Configuration.any_instance.stub(:action_mailer).and_return(mock_config)
    Rails.logger = Logger.new(STDOUT)
    SmtpURL::Railtie.any_instance.stub(:instance_variable_defined?).and_return(false)
  end

  let(:mock_config) do
    mock('mock_config').as_null_object
  end

  context 'with SMTP_URL defined' do
    before do
      ENV['SMTP_URL'] = 'smtp://localhost:1025'
    end

    it "should setup action_mailer settings when SMTP_URL is set" do
      mock_config.should_receive(:delivery_method=).with(:smtp)
      mock_config.should_receive(:smtp_settings=)
      SmtpURL::Railtie.run_initializers
    end

    after do
      ENV['SMTP_URL'] = nil
    end
  end

  context 'without SMTP_URL defined' do
    it "should log a warning if SMTP_URL is not set" do
      Rails.logger.should_receive(:warn).with('SmtpURL did not setup your email delivery because the SMTP_URL env var was missing')
      SmtpURL::Railtie.run_initializers
    end
  end
end
