require 'datastore/memory_datastore/base_repository'
require 'mocks/test_model'

module MemoryDatastore
  describe BaseRepository do
    before(:each) do
      @datastore = BaseRepository.new
      @mock = TestModel.new
    end
    it "should create a hash for the records" do
      @datastore.records.should == {}
    end

    it "should save an object to its store and issue it an ID" do
      @datastore.save(@mock)
      @mock.id.should == 1
      @datastore.records[1].should == @mock
    end

    it "should return an record from its id" do
      @datastore.records[1] = @mock
      @datastore.find_by_id(1).should == @mock
    end
  end
end
