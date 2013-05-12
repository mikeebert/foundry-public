shared_examples "task repository" do
  before(:each) do
    @params = {:week => 1,
               :title => "Sample task",
               :apprenticeship_id => 1}
    @task = @task_datastore.new(@params)
  end

  it "should be able to return a new model" do
    @task_datastore.new.should be_an_instance_of(@task_datastore.model_class)
  end

  it "should pass attributes through to create a new task" do
    task = @task_datastore.new(@params)
    task.week.should == 1
    task.title.should == "Sample task"
  end

  it "should store a task and issue it an id" do
    @task_datastore.save(@task)  
    @task.id.should be_an_instance_of(Fixnum)
  end

  it "should find a task by it's id" do
    @task_datastore.save(@task)
    @task_datastore.find_by_id(@task.id).should == @task
  end

  it "should know all its records" do
    @task_datastore.save(@task)
    @task_datastore.all.should == [@task]
  end

  it "should reset its records" do
    @task_datastore.save(@task)  
    @task_datastore.reset
    @task_datastore.all.should == []
  end

  it "should delete an object from it's stores" do
    @task_datastore.save(@task)
    @task_datastore.all.should include(@task)
    @task_datastore.delete(@task)
    @task_datastore.all.should == []
  end

  describe "Tasks" do
    before(:each) do
      @task2 = @task_datastore.new(@params)
    end

    it "should not return weekly tasks when asked for general tasks" do
      @task.week = 0
      @task_datastore.save(@task)
      @task_datastore.save(@task2)
      @task_datastore.general_tasks_for_apprentice(1).should == [@task]
    end            

    describe "Weekly Tasks" do
      it "should return all the weekly tasks for an apprenticeship on a given week" do
        @task.week = 2
        @task_datastore.save(@task)
        @task2 = @task_datastore.new(@params)
        @task2.week = 2
        @task_datastore.save(@task2)
        @task_datastore.apprenticeship_week(1,2).should == [@task, @task2]
      end

      it "should return all the weekly tasks for a user regardless of week" do
        @task2.week = 2
        @task_datastore.save(@task)
        @task_datastore.save(@task2)
        @task_datastore.all_weekly_tasks_for(1).should == [@task, @task2]
      end
    end

    describe "General Tasks" do
      it "should return all the general tasks for a user" do
        @task.week = 0
        @task2.week = 0
        @task_datastore.save(@task)
        @task_datastore.save(@task2)
        @task_datastore.general_tasks_for_apprentice(1).should == [@task, @task2]
      end
    end

  end   
end
