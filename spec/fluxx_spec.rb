require 'spec_helper'

describe Fluxx do
  describe "can connect to client" do
    before do
      Fluxx.client_id = 'e75193afb6e6fcbe1c81d277f5bb417bcb76826f516848da843902e6186d0214'
      Fluxx.client_secret = 'd33a841566198930caea3d9b3a5cbeeea1cfb5191794f45f0205f909f83d7c35'
      Fluxx.client_name = 'mhs'
      Fluxx::SERVER = 'fluxx.dev:3000'
    end

    it "should allow a simple connection" do
      VCR.use_cassette 'fluxx/connect' do
        expect(Fluxx.request).to eq('f25b21a5e652ad523b5730d377774ea85c271c7a8d002b1efb285892677e79db')
      end
    end
  end
end
