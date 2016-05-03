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

def auth_user(protocol)
  case protocol
  when :http
    VCR.use_cassette(AUTH_USER) do
      Fluxx.configure do |config|
        config.server_url = CONFIG["http_server_url"]
        config.oauth_client_id = CONFIG["oauth_client_id"]
        config.oauth_client_secret = CONFIG["oauth_client_secret"]
      end
    end
  when :druby
    Fluxx.configure do |config|
      config.protocol = :druby
      config.server_url = CONFIG["drb_server_url"]
      config.client_id = CONFIG["client_id"]
      config.persistence_token = CONFIG["persistence_token"]
    end
  end
end

# Used for Minitest reusable specs
# all reusable specs are in test/*/modules/*_spec.rb
class Module
  def it(description, &block)
    define_method "test_#{description}", &block
  end
end