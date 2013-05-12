require 'spec_helper'
require 'repository'
require 'datastore/dm_datastore/models/apprenticeship'
require 'datastore/shared_examples/models/apprenticeship_examples'
require 'datastore/dm_datastore/user'
require 'datastore/dm_datastore/task'
require 'datastore/dm_datastore/feedback'
require 'datastore/dm_datastore/blog_post'

describe "DataMapper Apprenticeship" do

  before(:each) do
    Apprenticeship.destroy
    params = {:start_date => Date.new(2012,7,1),
              :end_date => Date.new(2012,7,31),
              :apprentice_id => 1, 
              :mentor_id => 2}
    @apprenticeship = Apprenticeship.new(params)
    @apprenticeship.save
    @user_datastore = DmDatastore::User.new
    @task_datastore = DmDatastore::Task.new
    @feedback_repository = DmDatastore::Feedback.new
    @blogpost_repository = DmDatastore::Blogpost.new
  end

  it_behaves_like "apprenticeship model"

end
