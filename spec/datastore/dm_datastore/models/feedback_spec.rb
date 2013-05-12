require 'spec_helper'
require 'date'
require 'datastore/dm_datastore/models/feedback.rb'
require 'datastore/shared_examples/models/feedback_examples'
require 'datastore/dm_datastore/user'

describe "DataMapper Feedback" do
  before(:each) do
    @feedback = ::Feedback.new(:author_id => 1, 
                               :week => 1,
                               :apprenticeship_id => 1,
                               :rating => 5,
                               :good => "some text",
                               :improve => "some text",
                               :change => "some text")
    @feedback.save
    @feedback_class = ::Feedback
    @user_datastore = DmDatastore::User.new
  end

  it_behaves_like "feedback model"
end
