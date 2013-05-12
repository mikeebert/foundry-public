require 'mocks/mock_datastore'

shared_examples "user model" do
  it "should take parameters and set the name and email attributes" do
    @user.name.should == "Mike"
    @user.email.should == "test@test.com"
  end

  context "User password and authentication" do
    it "should set a bcrypt password that is not a string but matches correct string" do
      @user.password = "password"
      @user.password.should_not be_an_instance_of(String)
      @user.password.should == "password"
    end

    it "should return true when authenticating the correct password" do
      @user.password = "password"
      @user.authenticate("password").should == true
    end

    it "should return false when authenticating the wrong password" do
      @user.password = "right_password"
      @user.authenticate("wrong_password").should == false
    end
  end

  it "should ask the datastore for all the apprenticeships associated with a user" do
    @user.id = 1
    datastore = MockDatastore.new
    Repository.should_receive(:for).and_return(datastore)
    datastore.should_receive(:user_apprenticeships).with(1)
    @user.apprenticeships
  end
end
