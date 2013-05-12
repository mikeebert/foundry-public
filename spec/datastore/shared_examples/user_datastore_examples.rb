shared_examples "user repository" do
  before(:each) do
    @user = @user_datastore.new(:name => "Mike", 
                                :email => "test@test.com")

  end

  it "should be able to pass attributes through to create a valid user" do
    user = @user_datastore.new(:name => "Mike", :email => "test@test.com")
    user.name.should == "Mike"
    user.email.should == "test@test.com"
  end

  it "should reset it's stores" do
    @user_datastore.reset
    @user_datastore.all.should == []
  end

  context "saving a user in the repository" do
    before(:each) do
      @user_datastore.save(@user)
    end

    it "should save an object to its store and issue it an ID" do
      @user.id.should be_an_instance_of(Fixnum)
    end 

    it "should find a user by its ID" do
      @user_datastore.find_by_id(@user.id).should == @user
    end

    it "should find a user by an email" do
      @user_datastore.find_by_email('test@test.com').should == @user  
    end

    it "should return nil for the wrong email" do
      @user_datastore.find_by_email("wrong_email").should == nil  
    end

  end
end

