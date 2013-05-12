require 'spec_helper'
require 'repository'
require 'date'
require 'datastore/memory_datastore/models/apprenticeship'
require 'datastore/shared_examples/models/apprenticeship_examples'
require 'datastore/memory_datastore/apprenticeship'
require 'datastore/memory_datastore/user'
require 'datastore/memory_datastore/task'
require 'datastore/memory_datastore/feedback'
require 'datastore/memory_datastore/blog_post'
require 'datastore/memory_datastore/models/user'
require 'datastore/memory_datastore/models/feedback'
require 'datastore/memory_datastore/models/task'
require 'datastore/memory_datastore/models/blog_post'

module Memory
  describe Apprenticeship do
    before(:each) do
      params = {:start_date => Date.new(2012,7,1),
                :end_date => Date.new(2012,7,31),
                :apprentice_id => 1, 
                :mentor_id => 2}
      @apprenticeship = Apprenticeship.new(params)
      Repository.repositories[:apprenticeship] = MemoryDatastore::Apprenticeship.new
      Repository.for(:apprenticeship).save(@apprenticeship)
      @user_datastore = MemoryDatastore::User.new
      @task_datastore = MemoryDatastore::Task.new
      @feedback_repository = MemoryDatastore::Feedback.new
      @blogpost_repository = MemoryDatastore::Blogpost.new
    end

    it_behaves_like "apprenticeship model"

  end
end
