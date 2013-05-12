require "datastore/memory_datastore/memory_repository"
require "mocks/mock_datastore"

module MemoryDatastore
  describe MemoryRepository do
    before(:each) do      
      @datastore = MemoryRepository.new
    end

    it "should create a hash of data stores" do
      @datastore.store.should be_an_instance_of(Hash)
    end

    it "should take types up on creation" do
      @datastore = MemoryRepository.new([:some_class])
      @datastore.store.keys.should include(:some_class)
    end

    it "should add data to its stores for multiple classes" do
      sample = :sample
      sample1 = :sample1
      classes = [sample, sample1]
      @datastore.add_datastores(classes)
      @datastore.store.should include({:sample => {}, :sample1 => {}})    
    end

    it "returns the proper store for a key" do
      @datastore.store = {:user => :user_store, :apprenticeship => :apprenticeship_store}
      @datastore.for(:user).should == :user_store
    end
    
    it "should tell the datastores to reset" do
      store1 = MockDatastore.new
      store2 = MockDatastore.new
      @datastore.store[:store1] = store1
      @datastore.store[:store2] = store2
      @datastore.clear_all
      store1.asked_to_reset.should == true
      store2.asked_to_reset.should == true
    end

    #  it "should initialize with a datastore" do
    #    MemoryRepository.should == :something
    #  end

    #  it "should return a datastore for user" do
    #    puts MemoryRepository.methods.sort
    #    MemoryRepository.add_datastores(:user)
    #    puts MemoryRepository.class_variables
    #    db = stub
    #    Datastore::DatastoreFactory.should_receive(:new).twice.and_return(db)
    #    MemoryRepository.for(:user).should == db
    #  end
  end
end
