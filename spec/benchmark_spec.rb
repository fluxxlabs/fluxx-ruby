require 'spec_helper'
require 'benchmark'

describe 'time per request' do
  before do
    Fluxx.client_id = 'e75193afb6e6fcbe1c81d277f5bb417bcb76826f516848da843902e6186d0214'
    Fluxx.client_secret = 'd33a841566198930caea3d9b3a5cbeeea1cfb5191794f45f0205f909f83d7c35'
    Fluxx.client_name = 'mhs'
    Fluxx::SERVER = 'fluxx.dev:3000'
    Fluxx.request
  end

  it 'should take less time with a keep-alive that is longer' do
    expect(Benchmark.realtime do
      for i in 1..5
        Fluxx::User.retrieve()
      end
    end).to be < 0.3
  end
end
