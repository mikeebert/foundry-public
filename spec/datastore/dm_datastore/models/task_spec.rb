require 'spec_helper'
require 'datastore/dm_datastore/models/task.rb'
require 'datastore/shared_examples/models/task_examples'
require 'datastore/dm_datastore/apprenticeship'
require 'datastore/dm_datastore/models/apprenticeship'

describe "DataMapper Task" do
  before(:each) do
    Task.destroy
    @task = Task.new(apprenticeship_id: 1,
                     week: 1, 
                     title: "Awesome", 
                     note: "sweet note", 
                     points: 4,
                     tags: [1,2,3])
    @task.save
    @task_class = Task
    @apprenticeship = DmDatastore::Apprenticeship.new
    @apprenticeship.reset
    Repository.repositories[:apprenticeship] = @apprenticeship
  end

  it_behaves_like "task model"
end
