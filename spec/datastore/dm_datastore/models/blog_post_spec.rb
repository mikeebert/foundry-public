require 'spec_helper'
require 'datastore/dm_datastore/models/blog_post'
require 'datastore/shared_examples/models/blog_post_examples'

describe "DataMapper Blogpost" do

  before(:each) do
    Blogpost.destroy
    params = {:apprenticeship_id => 1,
               :week => 1,
               :title => "Post Title",
               :url => "http://www.example.com"}
    @post = Blogpost.new(params)
    @post_class = Blogpost
    @post.save
  end

  it_behaves_like "blogpost model"

end
