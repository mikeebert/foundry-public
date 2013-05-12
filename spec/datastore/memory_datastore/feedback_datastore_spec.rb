require 'datastore/memory_datastore/feedback'
require 'datastore/memory_datastore/models/feedback'
require 'datastore/shared_examples/feedback_repository_examples'
require 'datastore/memory_datastore/models/apprenticeship'
require 'datastore/memory_datastore/apprenticeship'
require 'repository'

module MemoryDatastore
  describe Feedback do
    before(:each) do
      @feedback_datastore = Feedback.new
      @feedback_datastore.reset
    end

    it "should know its model class" do
      @feedback_datastore.model_class.should == Memory::Feedback
    end

    it_behaves_like "feedback repository"

    it "should return an array of the feedback for an apprenticeship and a week" do
      @feedback = @feedback_datastore.new
      @feedback.apprenticeship_id = 1
      @feedback.week = 2
      @feedback_datastore.save(@feedback)
      @feedback_datastore.feedback_for_apprenticeship_and_week(1, 2).should == [@feedback] 
    end

  end
end
