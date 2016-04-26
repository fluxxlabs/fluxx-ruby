require_relative "../test_helper"

# List objects will be instantiated from dynamically generated
# classes that map to API endpoints
describe Fluxx::UserListObject do

  before do
    Fluxx.reset_config
    set_protocol(:http)
  end

  describe Fluxx::User do
    before do
      VCR.use_cassette(HTTP_FETCH_USERS) do
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
      assert @users.first.is_a?(Fluxx::UserApiResource)
    end

    it "should have access to the opts" do
      assert @users.opts.is_a?(Hash)
    end

    it "should provide a total_entries in the opts" do
      assert @users.opts.has_key?(:total_entries)
      assert @users.opts[:total_entries].is_a?(Fixnum)
    end

    it "should provide a total_pages in the opts" do
      assert @users.opts.has_key?(:total_pages)
      assert @users.opts[:total_pages].is_a?(Fixnum)
    end

    it "should be on the first page" do
      assert @users.opts.has_key?(:current_page)
      assert @users.opts[:current_page] == 1
    end

    it "should return another 25 paginated results" do
      VCR.use_cassette(HTTP_FETCH_USERS_PAGE2) do
        @users = @users.next_page
        assert @users.opts[:current_page] == 2
      end
    end

  end

end