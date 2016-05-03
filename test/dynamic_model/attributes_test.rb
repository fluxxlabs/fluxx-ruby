require_relative "../test_helper"
require_relative "./modules/attribute_spec"

describe Fluxx::ModelAttribute do

  describe "HTTP" do
    before do
      Fluxx.reset_config
      auth_user(:http)

      VCR.use_cassette(FETCH_DYN_MODELS) do
        @models = Fluxx::MachineModelType.list
        @model = @models.first
      end
    end

    # Include all the shared tests
    include Fluxx::DynamicModel::AttributeSpec
  end

  describe "DRUBY" do
    before do
      Fluxx.reset_config
      auth_user(:druby)

      VCR.use_cassette(FETCH_DYN_MODELS) do
        @models = Fluxx::MachineModelType.list
        @model = @models.first
      end
    end

    # Include all the shared tests
    include Fluxx::DynamicModel::AttributeSpec
  end

end