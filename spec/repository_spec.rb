require 'repository'
require 'mocks/mock_datastore'

describe Repository do
  it "should return a hash" do
    Repository.repositories.should be_an_instance_of(Hash)
  end

  it "should register a repo" do
    datastore = MockDatastore.new
    Repository.register(:mock, datastore)
    Repository.for(:mock).should == datastore
  end
end
