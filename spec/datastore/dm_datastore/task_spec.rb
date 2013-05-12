require 'spec_helper'
require 'datastore/dm_datastore/task'
require 'datastore/shared_examples/task_repository_examples'

module DmDatastore
  describe Task do
    before(:each) do
      @task_datastore = Task.new
      @task_datastore.model_class.destroy
    end

    it "should know its model class" do
      @task_datastore.model_class.should == ::Task
    end

    it_behaves_like "task repository"

  end
end
