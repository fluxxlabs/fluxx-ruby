require_relative "../test_helper"
require_relative "./modules/api_resource_spec"

describe Fluxx::MachineModelTypeListObject do

  describe "HTTP" do
    before do
      Fluxx.reset_config
      auth_user(:http)

      VCR.use_cassette(FETCH_DYN_MODELS) do
        @models = Fluxx::MachineModelType.list
        @model = @models.first
      end

      VCR.use_cassette(LOAD_DYN_MODEL) do
        klass = "Fluxx::#{@model.model_type}".constantize
        @dyn_models = klass.list
      end
    end

    include Fluxx::DynamicModel::ApiResourceSpec
  end

  describe "DRUBY" do
    before do
      Fluxx.reset_config
      auth_user(:druby)

      VCR.use_cassette(FETCH_DYN_MODELS) do
        @models = Fluxx::MachineModelType.list
        @model = @models.first
      end

      VCR.use_cassette(LOAD_DYN_MODEL) do
        klass = "Fluxx::#{@model.model_type}".constantize
        @dyn_models = klass.list
      end
    end

    include Fluxx::DynamicModel::ApiResourceSpec
  end
end