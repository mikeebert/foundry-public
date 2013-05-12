shared_examples "feedback model" do
  it "should initialize with the correct attributes" do
    @feedback.author_id.should == 1
    @feedback.week.should == 1
    @feedback.apprenticeship_id.should == 1
    @feedback.created_at.strftime("%Y-%m-%d").should == DateTime.now.strftime("%Y-%m-%d")
    @feedback.rating.should == 5
    @feedback.good.should == "some text"
    @feedback.improve.should == "some text"
    @feedback.change.should == "some text"
  end

  it "should return the user as the author of the feedback" do
    Repository.repositories[:user] = @user_datastore
    @user_datastore.reset
    user = @user_datastore.new(name: "Mike", email: "test@test.com")
    Repository.for(:user).save(user)
    @feedback.author_id = user.id
    @feedback.author.should == user
  end

  it "should include an error for feedback with no rating" do
    feedback = @feedback_class.new
    feedback.valid?.should == false
    feedback.errors.keys.should include(:rating)
  end

  it "should include errors for feedback with no week or apprenticeship id" do
    feedback = @feedback_class.new
    feedback.valid?.should == false
    feedback.errors.keys.should include(:week, :apprenticeship_id)
  end
end
