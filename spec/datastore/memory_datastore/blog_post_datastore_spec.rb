require 'datastore/memory_datastore/blog_post'
require 'datastore/memory_datastore/models/blog_post'
require 'datastore/shared_examples/blog_post_repository_examples'

module MemoryDatastore
  describe Blogpost do
    before(:each) do
      @post_repository = Blogpost.new
    end

    it "should know its model class" do
      @post_repository.model_class.should == Memory::Blogpost
    end

    it "should return all the posts for an apprenticeship and a week" do
      post = @post_repository.new
      post.apprenticeship_id = 1
      post.week = 1
      @post_repository.save(post)
      post2 = @post_repository.new
      post2.apprenticeship_id = 1
      post2.week = 1
      @post_repository.save(post2)
      @post_repository.posts_for_apprenticeship_and_week(1,1).should == [post, post2]
    end

    it_behaves_like "blogpost repository"

  end
end
