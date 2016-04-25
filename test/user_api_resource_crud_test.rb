require_relative "test_helper"

describe Fluxx::UserApiResource do
  describe "CRUD" do

    before do
      Fluxx.reset_config
      auth_user(:http)

      VCR.use_cassette(HTTP_FETCH_USERS) do
        users = Fluxx::User.list
        @user = users.first
      end
    end

    it "should be able to create a user" do
      VCR.use_cassette(HTTP_CREATE_USER) do

      end
    end

    it "should be able to update a user" do
      previous_name = @user.first_name
      VCR.use_cassette(HTTP_UPDATE_USER) do
        @user.update(first_name: "New User Name")
        assert @user.first_name == "New User Name"
      end
    end

  end
end