module Fluxx::DynamicModel::ApiResourceSpec

  it "should be able to load a list from a dynamic model" do
    assert @dyn_models.is_a?("Fluxx::#{@model.model_type.singularize}ListObject".constantize)
  end

  it "should be able to load the attributes for a dynamic model" do
    VCR.use_cassette(FETCH_ATTRIBUTES) do
      attrs = Fluxx::ModelAttribute.list
    end
  end

end