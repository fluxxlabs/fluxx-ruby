require_relative "../test_helper"
require_relative "./modules/list_spec"

describe Fluxx::MachineModelTypeListObject do

  describe "HTTP" do
    before do
      Fluxx.reset_config
      auth_user(:http)

      VCR.use_cassette(FETCH_DYN_MODELS) do
        @models = Fluxx::MachineModelType.list
      end
    end

    # Include all the shared tests
    include Fluxx::DynamicModel::ListSpec
  end

  describe "DRUBY" do
    before do
      Fluxx.reset_config
      auth_user(:druby)

      VCR.use_cassette(FETCH_DYN_MODELS) do
        @models = Fluxx::MachineModelType.list
      end
    end

    # Include all the shared tests
    include Fluxx::DynamicModel::ListSpec
  end
end