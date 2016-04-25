require_relative "test_helper"

describe Fluxx::UserApiResource do
  describe "CRUD" do

    before do
      Fluxx.reset_config
      auth_user(:http)

      VCR.use_cassette('users_http') do
        users = Fluxx::User.list
        @user = users.first
      end
    end

    it "should be able to create a user" do
      VCR.use_cassette("user_create_http") do

      end
    end

    it "should be able to update a user" do
      previous_name = @user.first_name
      VCR.use_cassette("user_update_http") do
        @user.update(first_name: "New User Name")
        assert @user.first_name == "New User Name"
      end
    end

  end
end