require_relative "../test_helper"
require_relative "./modules/crud_spec"

describe Fluxx::UserApiResource do
  describe "CRUD" do

    # Lets test creating, deleting and updating in order
    i_suck_and_my_tests_are_order_dependent!

    describe "HTTP" do
      before do
        Fluxx.reset_config
        auth_user(:http)

        VCR.use_cassette(FETCH_USERS) do
          users = Fluxx::User.list
          @user = users.last
        end
      end

      # Include all the shared tests
      include Fluxx::User::CrudSpec
    end

    describe "DRUBY" do
      before do
        Fluxx.reset_config
        auth_user(:druby)

        users = Fluxx::User.list
        @user = users.last
      end

      # Include all the shared tests
      include Fluxx::User::CrudSpec
    end

  end
end