require 'datastore/memory_datastore/user'
require 'datastore/memory_datastore/models/user'
require 'mocks/mock_user'
require 'datastore/shared_examples/user_datastore_examples'

module MemoryDatastore
  describe User do
    before(:each) do
      @user_datastore = User.new
    end

    it "should know the class of it's models" do
      @user_datastore.model_class.should == Memory::User
    end

    it "should be able to return a new Memmory::User" do
      @user_datastore.new.should be_an_instance_of(Memory::User)
    end

    it_behaves_like "user repository"
  end
end
