require 'datastore/memory_datastore/task'
require 'datastore/memory_datastore/models/task'
require 'datastore/shared_examples/task_repository_examples'
require 'mocks/mock_task'

module MemoryDatastore
  describe Task do
    before(:each) do
      @task_datastore = Task.new   
      @task_datastore.reset
    end

    it "should know its model class" do
      @task_datastore.model_class.should == Memory::Task
    end
    
    it_behaves_like "task repository"
  end
end
