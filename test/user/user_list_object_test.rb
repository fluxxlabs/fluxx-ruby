require_relative "../test_helper"
require_relative "./modules/list_object_spec"

# List objects will be instantiated from dynamically generated
# classes that map to API endpoints
describe Fluxx::UserListObject do

  describe "HTTP" do
    before do
      Fluxx.reset_config
      auth_user(:http)

      VCR.use_cassette(FETCH_USERS) do
        @users = Fluxx::User.list
      end
    end

    include Fluxx::ListObjectSpec
  end

  describe "DRUBY" do
    before do
      Fluxx.reset_config
      auth_user(:druby)

      VCR.use_cassette(FETCH_USERS) do
        @users = Fluxx::User.list
      end
    end

    include Fluxx::ListObjectSpec
  end
end