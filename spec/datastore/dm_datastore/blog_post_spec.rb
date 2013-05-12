require 'spec_helper'
require 'datastore/dm_datastore/blog_post'
require 'datastore/shared_examples/blog_post_repository_examples'

module DmDatastore
  describe Blogpost do
    before(:each) do
      @post_repository = Blogpost.new
    end

    it "should know its model class" do
      @post_repository.model_class.should == ::Blogpost
    end

    it_behaves_like "blogpost repository"
  end
end
