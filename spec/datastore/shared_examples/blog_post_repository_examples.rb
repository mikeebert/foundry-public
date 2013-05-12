shared_examples "blogpost repository" do

  it "should return a new model object" do
    @post_repository.new.should be_an_instance_of(@post_repository.model_class)
  end

  it "should store a blog post object and issue it and id" do
    post = @post_repository.new(:apprenticeship_id => 1,
                                :week => 1,
                                :title => "Post Title",
                                :url => "http://www.example.com")
    @post_repository.save(post)
    post.id.should be_an_instance_of(Fixnum)
    @post_repository.all.should include(post)
  end
end
