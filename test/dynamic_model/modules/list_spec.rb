module Fluxx::DynamicModel::ListSpec

  it "should be able to download a list of dynamic models" do
    assert @models.is_a?(Fluxx::MachineModelTypeListObject)
  end

  it "should have a Fluxx::MachineModelTypeApiResource as children" do
    # This will fail if there aren't any dyn models
    assert @models.first.is_a?(Fluxx::MachineModelTypeApiResource)
  end
end