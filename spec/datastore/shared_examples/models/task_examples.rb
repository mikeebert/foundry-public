require 'mocks/mock_datastore'

shared_examples "task model" do
  it "should have an apprenticeship_id, week, title, note, points, general status and tags" do
    @task.apprenticeship_id.should == 1
    @task.week.should == 1
    @task.title.should == "Awesome"
    @task.note.should == "sweet note"
    @task.points.should == 4
    @task.general.should == false
    @task.tags.should == [1,2,3]
  end

  it "a task with just a week and an apprenticeship id should be valid" do
    new_task = @task_class.new(:apprenticeship_id => 1,
                               :title => "Awesome")
    new_task.valid?.should == true
  end

  it "a task with a long title should be valid" do
    new_task = Task.new(apprenticeship_id: 1,
                        week: 1, 
                        title: "Some super long silly title with lots of words that is like really long")
    new_task.valid?.should == true
  end

 
  it "a task with apprenticeship id or title should not be valid and include errors" do
    new_task = @task_class.new
    new_task.valid?.should == false
    new_task.errors.keys.should include(:apprenticeship_id, :title)
  end


  it "should update its week, title, note and points" do
    @task.update(week: "2",
                 title: "Cool",
                 note: "super sweet note",
                 points: "2")
    @task.week.should == 2
    @task.title.should == "Cool"
    @task.note.should == "super sweet note"
    @task.points.should == 2
  end

  it "should be a general task if the week is 0" do
    @task.week = 0
    @task.general.should == true
  end

  it "should set the week to 0 for a general task" do
    task = @task.class.new(apprenticeship_id: 1, title: "Awesome", note: "sweet note", points: 4)
    task.week.should == 0
  end

  it "should initialize with an empty array of tags if none are passed through" do
    tagless_task = @task.class.new(apprenticeship_id: 1,
                            week: 1, 
                            title: "Awesome", 
                            note: "sweet note", 
                            points: 4)
    tagless_task.tags.should == []
  end

  it "should default to not being complete" do
    @task.complete.should_not == true
  end

  it "should update to complete when passed true" do
    params = {complete: "true"}
    @task.update(params)
    @task.complete?.should == true
  end  

  it "should provide an array of names for it's tags" do
    @task.display_tag_names.should == ["Crafting Code","TDD", "Refactoring"]
  end

  it "should ask the datastore for the apprenticeship it belongs to" do
    apprenticeship = @apprenticeship.new(:start_date => Date.today - 1,
                                        :end_date => Date.today,
                                        :apprentice_id => 1,
                                        :mentor_id => 2)
    Repository.for(:apprenticeship).save(apprenticeship)
    @task.apprenticeship_id = apprenticeship.id
    @task.apprenticeship.should == apprenticeship
  end

  it "should say a task created today is current" do
    apprenticeship = @apprenticeship.new(:start_date => Date.today - 1,
                                        :end_date => Date.today,
                                        :apprentice_id => 1,
                                        :mentor_id => 2)
    Repository.for(:apprenticeship).save(apprenticeship)
    @task.apprenticeship_id = apprenticeship.id
    @task.week = 1
    @task.current?.should == true    
  end

  it "should say a task is current ten days before the current day" do
   apprenticeship = @apprenticeship.new(:start_date => Date.today - 10,
                                       :end_date => Date.today + 2,
                                       :apprentice_id => 1,
                                       :mentor_id => 2)
    Repository.for(:apprenticeship).save(apprenticeship)
    @task.apprenticeship_id = apprenticeship.id
    @task.current?.should == true    
  end

  it "should say a task is not current 11 days before the current day" do
   apprenticeship = @apprenticeship.new(:start_date => Date.today - 11,
                                       :end_date => Date.today + 2,
                                       :apprentice_id => 1,
                                       :mentor_id => 2)
    Repository.for(:apprenticeship).save(apprenticeship)
    @task.apprenticeship_id = apprenticeship.id
    @task.week = 1
    @task.current?.should == false    
  end
end
