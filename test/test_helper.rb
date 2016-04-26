require 'minitest/autorun'
require 'byebug'
require_relative "../lib/fluxx"
require_relative "./vcr_actions"

require 'vcr'
require 'yaml'

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock
end

CONFIG = YAML::load_file(File.join(__dir__, 'config.yml'))

def load_cassette(name)
  "#{@protocol.to_s.upcase}_#{name}".constantize
end

def set_protocol(name)
  @protocol = name
  auth_user
end

def auth_user
  case @protocol
  when :http
    VCR.use_cassette(HTTP_AUTH_USER) do
      Fluxx.configure do |config|
        config.server_url = CONFIG["http_server_url"]
        config.oauth_client_id = CONFIG["oauth_client_id"]
        config.oauth_client_secret = CONFIG["oauth_client_secret"]
      end
    end
  when :druby
    VCR.use_cassette(DRUBY_AUTH_USER) do
      Fluxx.configure do |config|
        config.protocol = :druby
        config.server_url = CONFIG["drb_server_url"]
        config.client_id = CONFIG["client_id"]
        config.persistence_token = CONFIG["persistence_token"]
      end
    end
  end
end

class Module
  def it(description, &block)
    define_method "test_#{description}", &block
  end
end