require 'spec_helper'
require 'datastore/memory_datastore/models/task'
require 'datastore/memory_datastore/apprenticeship'
require 'datastore/shared_examples/models/task_examples'
require 'mocks/mock_datastore'
#require 'apprenticeship'
require 'date'

module Memory
  describe Task do
    before(:each) do
      @task = Task.new(apprenticeship_id: 1,
                       week: 1, 
                       title: "Awesome", 
                       note: "sweet note", 
                       points: 4,
                       tags: [1,2,3])
      @task_class = Task
      @apprenticeship = MemoryDatastore::Apprenticeship.new
      @apprenticeship.reset
      Repository.repositories[:apprenticeship] = @apprenticeship
    end

    it_behaves_like "task model"

  end
end
