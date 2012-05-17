require 'smtp_url'

describe SmtpURL, '#parse' do
  it "should set port to 25 is not in url" do
    url = "smtp://test.com"
    settings = SmtpURL.parse url
    settings[:port].should eq(25)
  end

  it "should allow setting port" do
    url = "smtp://test.com:587"
    settings = SmtpURL.parse url
    settings[:port].should eq(587)
  end

  it "should handle urls without authentication" do
    url = "smtp://test.com"
    settings = SmtpURL.parse url
    settings[:address].should eq('test.com')
    settings[:user_name].should eq(nil)
    settings[:passsword].should eq(nil)
  end

  it "should handle urls with authentication" do
    url = "smtp://user:secret@test.com"
    settings = SmtpURL.parse url
    settings[:address].should eq('test.com')
    settings[:user_name].should eq('user')
    settings[:password].should eq('secret')
  end

  it "should parse domain from query params" do
    url = "smtp://test.com/?domain=test2.com"
    settings = SmtpURL.parse url
    settings[:domain].should eq('test2.com')
  end

  it "should parse authentication from query params" do
    url = "smtp://user:secret@test.com/?authentication=digest"
    settings = SmtpURL.parse url
    settings[:user_name].should eq('user')
    settings[:password].should eq('secret')
    settings[:authentication].should eq(:digest)
  end

  it "should return empty hash for invalid url" do
    url = "just a string of stuff"
    settings = SmtpURL.parse url
    settings.should eq({})
  end

  it "should return empty hash if url is not smtp" do
    url = "http://test.com"
    settings = SmtpURL.parse url
    settings.should eq({})
  end
end
