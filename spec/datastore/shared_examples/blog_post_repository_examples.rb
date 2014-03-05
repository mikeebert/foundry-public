shared_examples "blogpost repository" do

  before(:each) do
    @params = {:apprenticeship_id => 1,
               :week => 1,
               :title => "Post Title",
               :url => "http://www.example.com"}
    @post = @post_repository.new(@params)
  end

  after :each do
    @post_repository.destroy_all
  end

  it "should return a new model object" do
    @post_repository.new.should be_an_instance_of(@post_repository.model_class)
  end

  it "should pass attributes through to create a new blog post" do
    post = @post_repository.new(@params)
    post.week.should == 1
    post.title.should == "Post Title"
    post.url.should == "http://www.example.com"
  end

  it "should store a blog post and issue it an id" do
    @post_repository.save(@post)
    @post.id.should be_an_instance_of(Fixnum)
    @post_repository.all.should include(@post)
  end

  it "should find blog posts by its id" do
    @post_repository.save(@post)
    @post_repository.find_by_id(@post.id).should == @post
  end

  it "should know all its records" do
    @post_repository.save(@post)
    @post_repository.all.should == [@post]
  end

end
