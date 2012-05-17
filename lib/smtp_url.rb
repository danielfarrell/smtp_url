require 'uri'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/hash/keys'

module SmtpURL
  VERSION = '0.0.2'

  def self.parse(uri)
    config = URI.parse(uri)
    return {} if config.scheme != 'smtp'
    query_params = split_query_params(config.query)
    settings = { :address        => config.host,
                 :port           => config.port || 25,
                 :domain         => query_params[:domain],
                 :user_name      => config.user,
                 :password       => config.password,
                 :authentication => query_params[:authentication].try(:to_sym)
               }
    settings.reject!{ |key,value| value.nil? }
    settings
  rescue URI::InvalidURIError
    return {}
  end

  private
  def self.split_query_params(query = nil)
    return {} unless query
    Hash[query.split("&").map{ |pair| pair.split("=") }].symbolize_keys
  end

end
