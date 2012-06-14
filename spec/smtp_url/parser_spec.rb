require 'smtp_url/invalid_url_exception'
require 'smtp_url/parser'

describe SmtpURL::Parser, '#parse' do
  it "should set port to 25 is not in url" do
    url = "smtp://test.com"
    settings = SmtpURL::Parser.new(url).parse
    settings[:port].should eq(25)
  end

  it "should allow setting port" do
    url = "smtp://test.com:587"
    settings = SmtpURL::Parser.new(url).parse
    settings[:port].should eq(587)
  end

  it "should handle urls without authentication" do
    url = "smtp://test.com"
    settings = SmtpURL::Parser.new(url).parse
    settings[:address].should eq('test.com')
    settings[:user_name].should eq(nil)
    settings[:passsword].should eq(nil)
  end

  it "should handle urls with authentication" do
    url = "smtp://user:secret@test.com"
    settings = SmtpURL::Parser.new(url).parse
    settings[:address].should eq('test.com')
    settings[:user_name].should eq('user')
    settings[:password].should eq('secret')
  end

  it "should parse domain from query params" do
    url = "smtp://test.com/?domain=test2.com"
    settings = SmtpURL::Parser.new(url).parse
    settings[:domain].should eq('test2.com')
  end

  it "should parse authentication from query params" do
    url = "smtp://user:secret@test.com/?authentication=digest"
    settings = SmtpURL::Parser.new(url).parse
    settings[:user_name].should eq('user')
    settings[:password].should eq('secret')
    settings[:authentication].should eq(:digest)
  end

  it "should raise InvalidUriException for invalid url" do
    url = "just a string of stuff"
    lambda {SmtpURL::Parser.new(url).parse}.should raise_error(SmtpURL::InvalidUrlException, "Could not parse SMTP_URL env var")
  end

  it "should raise InvalidUriException if url is not smtp" do
    url = "http://test.com"
    lambda {SmtpURL::Parser.new(url).parse}.should raise_error(SmtpURL::InvalidUrlException, "Improper format of SMTP_URL env var, must be smtp://")
  end
end
