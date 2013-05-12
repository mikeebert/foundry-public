shared_examples "apprenticeship repository" do
  before(:each) do
    @params = {start_date: "2012-07-01", end_date: "2012-07-31", 
               apprentice_id: 1, mentor_id: 3}
    @apprenticeship = @apprenticeship_datastore.new(@params)
  end
  
  it "should return a new Apprenticeship model" do
    @apprenticeship_datastore.new.should be_an_instance_of(@apprenticeship_datastore.model_class)
  end

  it "should save an object to its store and issue it an ID" do
    @apprenticeship_datastore.save(@apprenticeship)
    @apprenticeship.id.should be_an_instance_of(Fixnum)
    @apprenticeship_datastore.all.should include(@apprenticeship)
  end

  it "should return an apprenticeship from its id" do
    @apprenticeship_datastore.save(@apprenticeship)
    @apprenticeship_datastore.find_by_id(@apprenticeship.id).should == @apprenticeship
  end

  it "should load all of the records" do
    apprenticeship2 = @apprenticeship_datastore.new(@params)
    @apprenticeship_datastore.save(@apprenticeship)
    @apprenticeship_datastore.save(apprenticeship2)
    @apprenticeship_datastore.all.should == [@apprenticeship,apprenticeship2]
  end

  it "should reset it's stores" do
    apprenticeship2 = @apprenticeship_datastore.new(@params)
    @apprenticeship_datastore.save(@apprenticeship)
    @apprenticeship_datastore.save(apprenticeship2)
    @apprenticeship_datastore.all.should == [@apprenticeship,apprenticeship2]
    @apprenticeship_datastore.reset
    @apprenticeship_datastore.all.should == []
  end

  it "should return the apprenticeships that a user is a part of" do
    apprenticeship2 = @apprenticeship_datastore.new(@params)
    @apprenticeship.apprentice_id = 1
    apprenticeship2.mentor_id = 1
    @apprenticeship_datastore.save(@apprenticeship)
    @apprenticeship_datastore.save(apprenticeship2)
    @apprenticeship_datastore.user_apprenticeships(1).should == [@apprenticeship, apprenticeship2]
  end

  it "should not return the apprenticeships for which the user is not a part of" do
    @apprenticeship.apprentice_id = 1
    apprenticeship2 = @apprenticeship_datastore.new(@params)
    apprenticeship2.apprentice_id = 2
    apprenticeship2.mentor_id = 3
    @apprenticeship_datastore.save(@apprenticeship)
    @apprenticeship_datastore.save(apprenticeship2)
    @apprenticeship_datastore.user_apprenticeships(1).should_not include(apprenticeship2)
  end


end
