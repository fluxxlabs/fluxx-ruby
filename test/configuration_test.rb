require_relative "test_helper"

describe Fluxx::Configuration do
  before do
    Fluxx.reset_config
  end

  it "should throw an error without required configuration" do
    assert_raises Fluxx::FluxxConfigurationError do 
      Fluxx.configure {}
    end
  end

  it "should set the configuration for the http protocol" do
    Fluxx.stub :get_access_token, true do
      Fluxx.configure do |config|
        config.oauth_client_id = "ABC"
        config.oauth_client_secret = "XYZ123"
        config.server_url = "http://example.com"
      end

      assert Fluxx.oauth_client_id == "ABC"
      assert Fluxx.oauth_client_secret == "XYZ123"
      assert Fluxx.server_url = "http://example.com"
    end
  end

  it "should set the configuration for the druby protocol" do
    Fluxx.stub :connect_to_drb_server, true do
      Fluxx.configure do |config|
        config.protocol = :druby
        config.client_id  = 1
        config.server_url = "druby://test.com"
        config.persistence_token = "AAZZ"
      end

      assert Fluxx.client_id == 1
      assert Fluxx.server_url == "druby://test.com"
      assert Fluxx.persistence_token == "AAZZ"
    end
  end

end