require 'datastore/memory_datastore/models/blog_post'
require 'datastore/shared_examples/models/blog_post_examples'

module Memory
  describe Blogpost do
    before(:each) do
      params = {:apprenticeship_id => 1,
                :week => 1,
                :title => "Post Title",
                :url => "http://www.example.com"}
      @post = Blogpost.new(params)
      @post_class = Blogpost
    end

    it_behaves_like "blogpost model"
  end
end
