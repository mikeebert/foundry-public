require 'spec_helper'
require 'datastore/dm_datastore/models/user'
require 'datastore/shared_examples/models/user_examples'

describe "DataMapper user" do
  before(:all) do
    User.destroy
    @user = User.create(:name => "Mike", :email => "test@test.com")
  end
 
  it "should have an id" do
    @user.save
    @user.id.should be_an_instance_of(Fixnum)
  end

  it_behaves_like "user model"
end
