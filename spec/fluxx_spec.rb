require 'spec_helper'

describe Fluxx do
  before do
    Fluxx.client_id = 'e75193afb6e6fcbe1c81d277f5bb417bcb76826f516848da843902e6186d0214'
    Fluxx.client_secret = 'd33a841566198930caea3d9b3a5cbeeea1cfb5191794f45f0205f909f83d7c35'
    Fluxx.client_name = 'mhs'
    Fluxx::SERVER = 'fluxx.dev:3000'
  end

  describe "can connect to client" do
    it "should allow a simple connection" do
      VCR.use_cassette 'fluxx/connect' do
        expect(Fluxx.request).to_not be_empty
      end
    end
  end

  describe Fluxx::User do
    it "should be able to fetch the current user" do
      VCR.use_cassette 'fluxx/user/current' do
        user = Fluxx::User.retrieve()
        expect(user.first_name).to eq('Michael')
      end
    end
  end

  describe Fluxx::Form do
    it "should be able to fetch a form" do
      VCR.use_cassette('fluxx/form/fetch') do
        form = Fluxx::Form.retrieve()
        expect(form.id).to eq(1)
      end
    end
  end
end
