require 'datastore/memory_datastore/memory_repo_factory.rb'
require 'datastore/memory_datastore/user.rb'
require 'datastore/memory_datastore/task.rb'
require 'datastore/memory_datastore/apprenticeship.rb'
require 'datastore/memory_datastore/feedback'
require 'datastore/memory_datastore/blog_post'

module MemoryDatastore
  describe MemoryRepoFactory do
    before(:each) do
      @factory = MemoryRepoFactory.new
      @stub_store = stub 
    end
    
    it "should return a datasture if passed an eligible symbol" do
      user_datastore = stub
      User.should_receive(:new).and_return(user_datastore)
      @factory.create(:user).should == user_datastore
    end
    
    it "should return a User datastore" do
      User.should_receive(:new).and_return(@stub_store)
      @factory.create(:user).should == @stub_store
    end

    it "should return a User datastore" do
      Apprenticeship.should_receive(:new).and_return(@stub_store)
      @factory.create(:apprenticeship).should == @stub_store
    end

    it "should return a Task datastore" do
      Task.should_receive(:new).and_return(@stub_store)
      @factory.create(:task).should == @stub_store
    end
    
    it "should return a Feedback datastore" do
      Feedback.should_receive(:new).and_return(@stub_store)
      @factory.create(:feedback).should == @stub_store
    end

    it "should return a Blogpost datastore" do
      @factory.create(:blogpost).should be_an_instance_of(Blogpost)
    end
  end
end
