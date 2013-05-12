require 'spec_helper'
require 'datastore/dm_datastore/feedback'
require 'datastore/shared_examples/feedback_repository_examples'

module DmDatastore  
  describe Feedback do
    before(:each) do
      @feedback_datastore = Feedback.new
      @feedback_datastore.model_class.destroy
    end

    it "should know its model class" do
      @feedback_datastore.model_class.should == ::Feedback
    end

    it_behaves_like "feedback repository"
  end
end
