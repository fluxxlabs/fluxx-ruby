require_relative "../test_helper"
require_relative "./modules/api_resource_spec"

describe Fluxx::UserApiResource do

  describe "HTTP" do
    before do
      Fluxx.reset_config
      auth_user(:http)

      VCR.use_cassette(FETCH_USERS) do
        users = Fluxx::User.list
        @user = users.first
      end
    end

    # Include all the shared tests
    include Fluxx::User::ApiResourceSpec
  end

  describe "DRUBY" do
    before do
      Fluxx.reset_config
      auth_user(:druby)

      users = Fluxx::User.list
      @user = users.first
    end

    # Include all the shared tests
    include Fluxx::User::ApiResourceSpec
  end

end