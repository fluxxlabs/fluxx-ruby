module Fluxx::CrudSpec
  it "should be able to create a user" do
    VCR.use_cassette(CREATE_USER) do
      user = Fluxx::User.create(first_name: "Tester", last_name: "McTestFace")
      assert user.first_name = "Tester"
      assert user.last_name = "McTestFace"
      assert user.id
      assert user.errors.empty?
    end
  end

  it "should receive error messages when creating a user" do
    VCR.use_cassette(CREATE_USER_ERROR) do
      user = Fluxx::User.create({something: 'nothing'})
      assert @user.errors
      assert !user.errors.empty?
    end
  end

  it "should be able to update a user" do
    previous_name = @user.first_name
    VCR.use_cassette(UPDATE_USER) do
      @user.update(first_name: "New User Name")
      assert @user.first_name == "New User Name"
    end
  end

  it "should be able to destroy a user" do
    VCR.use_cassette(DESTROY_USER) do
      @user.destroy

      # Destroying the object freezes it's values
      err = assert_raises RuntimeError do 
        @user.first_name = "ChangedFirst"
      end
      assert err.message == "can't modify frozen Hash"
    end
  end
end