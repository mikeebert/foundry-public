shared_examples "blogpost model" do

  it "should initialize with the correct attributes" do
    @post.apprenticeship_id.should == 1
    @post.week.should == 1
    @post.title.should == "Post Title"
    @post.url.should == "http://www.example.com"
  end

  it "should set a valid url even if passed no 'http://' prefix" do
    @post.url = "www.example.com"
    @post.set_url
    @post.url.should == "http://www.example.com"
  end
  
  it "a valid post should have no errors" do
    @post.valid?.should == true
    @post.errors.should be_empty
  end

  it "should set a valid url if passed the 'http://' prefix" do
    post = @post_class.new(:title => "some title", :url => "http://www.example.com")
    post.url.should == "http://www.example.com"
  end
  
  it "a post with no title should not be valid" do
    post = @post_class.new(:url => "http://www.test.com")
    post.valid?.should == false
    post.errors.keys.should include(:title)
  end

  it "a post with no url should not be valid" do
    post = @post_class.new(:title => "some title")
    post.valid?.should == false
    post.errors.keys.should include(:url)
  end
end
