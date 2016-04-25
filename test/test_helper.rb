require 'minitest/autorun'
require 'byebug'
require_relative "../lib/fluxx"

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock
end

OAUTH_CLIENT_ID = "a6a6ffbb14029e834926555d50bd25126221a2c081eee6c66794b457f1772b05"
OAUTH_CLIENT_SECRET = "12116326a8c005f5f2bc3474784d9b093731eead90510f742a070a037cd99467"

def auth_user(protocol)
  VCR.use_cassette("user_http_auth") do
    Fluxx.configure do |config|
      config.server_url = "http://devtest3:3000"
      config.oauth_client_id = OAUTH_CLIENT_ID
      config.oauth_client_secret = OAUTH_CLIENT_SECRET
    end
  end
end