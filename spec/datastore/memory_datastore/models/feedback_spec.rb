require 'spec_helper'
require 'date'
require 'datastore/memory_datastore/models/feedback'
require 'datastore/memory_datastore/feedback'
require 'datastore/shared_examples/models/feedback_examples'

module Memory
  describe Feedback do
    before(:each) do
      @feedback = Feedback.new(:author_id => 1, 
                               :week => 1,
                               :apprenticeship_id => 1,
                               :rating => 5,
                               :good => "some text",
                               :improve => "some text",
                               :change => "some text")

      @feedback_class = Feedback
      Repository.repositories[:feedback] = MemoryDatastore::Feedback.new
      Repository.for(:feedback).save(@feedback)
      @user_datastore = MemoryDatastore::User.new
    end

    it_behaves_like "feedback model"
  end
end
