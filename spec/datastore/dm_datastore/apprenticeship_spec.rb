require 'spec_helper'
require 'datastore/dm_datastore/apprenticeship'
require 'datastore/dm_datastore/models/apprenticeship'
require 'datastore/shared_examples/apprenticeship_repository_examples'

module DmDatastore
  describe Apprenticeship do
    before(:each) do
      @apprenticeship_datastore = Apprenticeship.new
      @apprenticeship_datastore.model_class.destroy
    end

    it "should know its model class" do
      @apprenticeship_datastore.model_class.should == ::Apprenticeship
    end
    
    it_behaves_like "apprenticeship repository"
  end
end
