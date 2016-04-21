require_relative "test_helper"

# List objects will be instantiated from dynamically generated
# classes that map to API endpoints
describe Fluxx::ListObject do

  before do
    Fluxx.reset_config

    VCR.use_cassette("user_http_auth") do
      Fluxx.configure do |config|
        config.server_url = "http://devtest3:3000"
        config.oauth_client_id = OAUTH_CLIENT_ID
        config.oauth_client_secret = OAUTH_CLIENT_SECRET
      end
    end
  end

  describe Fluxx::User do
    before do
      VCR.use_cassette('user_http') do
        @users = Fluxx::User.list
      end
    end

    it "should have 25 results" do
      assert !@users.empty?
      assert @users.size == 25
      assert @users.length == 25
      assert @users.count == 25
    end

    it "should return the users as a UserListObject" do 
      assert @users.class.eql?(Fluxx::UserListObject)
    end

    it "should return the first user" do
      assert @users.first.class.eql?(Fluxx::UserApiResource)
    end

    it "should be on the first page" do
      assert @users.opts[:current_page] == 1
    end

    it "should return another 25 paginated results" do
      VCR.use_cassette("user_http_page_2") do
        @users = @users.next_page
      end

      assert @users.opts[:current_page] == 2
    end
  end

end