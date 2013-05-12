require 'datastore/memory_datastore/apprenticeship'
require 'datastore/memory_datastore/models/apprenticeship'
require 'datastore/shared_examples/apprenticeship_repository_examples'

module MemoryDatastore
  describe Apprenticeship do
    before(:each) do
      @apprenticeship_datastore = Apprenticeship.new
      @apprenticeship_datastore.reset
    end

    it "should know its model class" do
      @apprenticeship_datastore.model_class.should == Memory::Apprenticeship
    end
    it_behaves_like "apprenticeship repository"

  end
end
