shared_examples "feedback repository" do
  before(:each) do
    @feedback = @feedback_datastore.new(:author_id => 1, 
                                        :week => 1,
                                        :apprenticeship_id => 1,
                                        :rating => 5,
                                        :good => "some text",
                                        :improve => "some text",
                                        :change => "some text")

  end

  it "should return a new feedback model" do
    @feedback_datastore.new.should be_an_instance_of(@feedback_datastore.model_class)  
  end

  it "should store a feedback object and issue it an id" do
    @feedback_datastore.save(@feedback)
    @feedback.id.should be_an_instance_of(Fixnum)
    @feedback_datastore.all.should include(@feedback)
  end

  it "should find a feedback item by the id" do
    @feedback_datastore.save(@feedback)
    @feedback_datastore.find_by_id(@feedback.id).should == @feedback
  end

end
