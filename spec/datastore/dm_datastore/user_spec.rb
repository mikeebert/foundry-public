require 'spec_helper'
require 'datastore/shared_examples/user_datastore_examples'
require 'datastore/dm_datastore/user'
require 'datastore/dm_datastore/models/user'

module DmDatastore
  describe User do
    before(:each) do
      @user_datastore = User.new
      @user_datastore.model_class.destroy
    end

    it "should know the class of it's models" do
      @user_datastore.model_class.should == ::User
    end

    it "should be able to return a new DataMapper User" do
      @user_datastore.new.should be_an_instance_of(::User)
    end

    it_behaves_like "user repository"
  end
end
