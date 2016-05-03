module Fluxx::User::ApiResourceSpec
  it "should be a Fluxx::UserApiResource" do
    assert @user.is_a?(Fluxx::UserApiResource)
  end

  it "should not make another request for existing attributes" do
    assert_silent do
      # If this made another request, VCR would complain that it's not wrapped in a cassette
      # If it doesn't make the request, the test is good
      @user.first_name
    end
  end

  it "should have basic fields assessible through accessors" do
    assert @user.created_at.is_a?(DateTime)
    assert @user.id.is_a?(Fixnum)
    assert @user.first_name.is_a?(String)
  end

  it "should not be able to access methods that do not exist" do
    VCR.use_cassette(USER_BAD_ASSOCIATION) do  
      assert_raises Fluxx::FluxxMethodMissingError do 
        @user.method_that_does_not_exist
      end
    end
  end

  it "should be able to access the user_profiles association" do
    VCR.use_cassette(USER_PROFILES_ASSOCIATION) do
      user_profiles = @user.user_profiles
      assert user_profiles.is_a?(Fluxx::UserProfileListObject)
      assert user_profiles.size > 0
    end
  end
end