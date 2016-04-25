require_relative "test_helper"

describe Fluxx::UserApiResource do
  describe "CRUD" do

    # Lets test creating, deleting and updating in order
    i_suck_and_my_tests_are_order_dependent!

    before do
      Fluxx.reset_config
      auth_user(:http)

      VCR.use_cassette(HTTP_FETCH_USERS) do
        users = Fluxx::User.list
        @user = users.last
      end
    end

    it "should be able to create a user" do
      VCR.use_cassette(HTTP_CREATE_USER) do
        user = Fluxx::User.create(first_name: "Tester", last_name: "McTestFace")
        assert user.first_name = "Tester"
        assert user.last_name = "McTestFace"
        assert user.id
      end
    end

    it "should be able to update a user" do
      previous_name = @user.first_name
      VCR.use_cassette(HTTP_UPDATE_USER) do
        @user.update(first_name: "New User Name")
        assert @user.first_name == "New User Name"
      end
    end

    it "should be able to destroy a user" do
      VCR.use_cassette(HTTP_DESTROY_USER) do
        @user.destroy

        # Destroying the object freezes it's values
        err = assert_raises RuntimeError do 
          @user.first_name = "ChangedFirst"
        end
        assert err.message == "can't modify frozen Hash"
      end
    end

  end
end