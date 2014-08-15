require 'weeks'

shared_examples "apprenticeship model" do

  it "set the attributes on creation" do
    @apprenticeship.start_date.to_s.should == "2012-07-01"
    @apprenticeship.end_date.to_s.should == "2012-07-31"
    @apprenticeship.apprentice_id.should == 1
    @apprenticeship.mentor_id.should == 2
  end

  context "Associations" do
    before(:each) do
      Repository.repositories[:user] = @user_datastore
      @user_datastore.reset
    end

    it "should know who the apprentice is" do
      @user1 = @user_datastore.new(:name => "Mike", :email => "email")
      Repository.for(:user).save(@user1)
      @apprenticeship.apprentice_id = @user1.id
      @apprenticeship.apprentice.should == @user1
    end

    it "should know who the mentor is" do
      @user2 = @user_datastore.new(:name => "Mike", :email => "email")
      Repository.for(:user).save(@user2)
      @apprenticeship.mentor_id = @user2.id
      @apprenticeship.mentor.should == @user2
    end

    it "should know if an apprenticehsip includes an apprentice user" do
      user = @user_datastore.new(name: "Test", email: "test@test")
      Repository.for(:user).save(user)
      @apprenticeship.mentor_id = user.id
      @apprenticeship.include?(user).should == true
    end
  end

  context "weeks and dates" do
    it "should get the weeks from the Weeks class" do
      @apprenticeship.weeks.should == {1 => Date.new(2012,7,1),
                                       2 => Date.new(2012,7,2),
                                       3 => Date.new(2012,7,9),
                                       4 => Date.new(2012,7,16),
                                       5 => Date.new(2012,7,23),
                                       6 => Date.new(2012,7,30)}

    end

    it "should receive new weeks if an end date is changed" do
      @apprenticeship.weeks.should == {1 => Date.new(2012,7,1),
                                       2 => Date.new(2012,7,2),
                                       3 => Date.new(2012,7,9),
                                       4 => Date.new(2012,7,16),
                                       5 => Date.new(2012,7,23),
                                       6 => Date.new(2012,7,30)}
      @apprenticeship.end_date = Date.new(2012,8,15)
      @apprenticeship.weeks.should == {1 => Date.new(2012,7,1),
                                       2 => Date.new(2012,7,2),
                                       3 => Date.new(2012,7,9),
                                       4 => Date.new(2012,7,16),
                                       5 => Date.new(2012,7,23),
                                       6 => Date.new(2012,7,30),
                                       7 => Date.new(2012,8,6),
                                       8 => Date.new(2012,8,13)}
    end

    it "should return the current week as a hash with the number and date" do
      apprenticeship = @apprenticeship.class.new(:start_date => Date.today,
                                                 :end_date => Date.today)
      apprenticeship.current_week.should == {1 => Date.today}
    end

    it "should return the final week of an apprenticehsip" do
      apprenticeship = @apprenticeship.class.new(:start_date => (Date.today - 10),
                                                 :end_date => (Date.today - 10))
      apprenticeship.final_week.should == {1 => (Date.today - 10)}
    end

    it "should return the last week if the apprenticeship is past" do
      apprenticeship = @apprenticeship.class.new(:start_date => (Date.today - 10),
                                                 :end_date => (Date.today - 10))
      apprenticeship.current_week.should == {1 => (Date.today - 10)}
    end

    it "should return an integer that corresponds to the current week in the weeks hash" do
      apprenticeship = @apprenticeship.class.new(:start_date => Date.today,
                                                 :end_date => Date.today + 10)
      apprenticeship.current_week_number.should == 1
    end

    it "should return a date that corresponds to the Monday of the current week" do
      apprenticeship = @apprenticeship.class.new(:start_date => Date.today - 8,
                                                 :end_date => Date.today + 10)
      apprenticeship.current_week_date.should == most_recent_monday
    end

    it "should return the current week number if today is a Monday" do
      apprenticeship = @apprenticeship.class.new(:start_date => Date.new(2012,8,26),
                                                 :end_date => Date.new(2012,9,7))
      Date.stub(:today).and_return(Date.new(2012,8,27))
      apprenticeship.current_week_number.should == 2
    end

    context "past and future weeks" do
      before(:each) do
        @apprenticeship = @apprenticeship.class.new(:start_date => Date.new(2012,8,1),
                                                   :end_date => Date.new(2012,9,1))
        Date.stub(:today).and_return(Date.new(2012,8,14))
      end

      it "should return the current and future weeks" do
        @apprenticeship.current_and_future_weeks.should == {3 => Date.new(2012,8,13),
                                                            4 => Date.new(2012,8,20),
                                                            5 => Date.new(2012,8,27)}
      end

      it "should return the past weeks" do
        @apprenticeship.past_weeks.should == {1 => Date.new(2012,8,1),
                                              2 => Date.new(2012,8,6)}
      end
    end

    it "should return an array of weeks included in the last 10 days for an apprenticeship less than one week" do
      apprenticeship = @apprenticeship.class.new
      apprenticeship.start_date = Date.today
      apprenticeship.end_date = Date.today
      apprenticeship.weeks_starting_in_last_ten_days.should == [1]
    end

    it "should return an array of weeks included in the last 10 days for an apprenticeship longer than one week" do
      apprenticeship = @apprenticeship.class.new
      apprenticeship.start_date = Date.today - 7
      apprenticeship.end_date = Date.today
      apprenticeship.weeks_starting_in_last_ten_days.should == [1, 2]
    end

    
  end

  context "Tasks" do
    before(:each) do
      Repository.repositories[:task] = @task_datastore
      @task_datastore.reset
      @params = {title: "Some Title", 
                 apprenticeship_id: @apprenticeship.id, 
                 week: 3}
      @task1 = @task_datastore.new(@params)
      @task2 = @task_datastore.new(@params)
      @task3 = @task_datastore.new(@params)
      @task3.week = 4
      [@task1, @task2, @task3].each do |task| 
        Repository.for(:task).save(task)
      end
    end

    it "should get an array of tasks for a specific week" do
      @apprenticeship.tasks_for_week(3).should == [@task1, @task2]
      @apprenticeship.tasks_for_week(4).should == [@task3]
    end

    it "should ask the datastore for all the weekly tasks" do
      @apprenticeship.all_weekly_tasks.should == [@task1, @task2, @task3]
    end    

    it "should ask the datastore for all of the general tasks" do
      @task4 = @task_datastore.new(@params)
      @task4.week = 0
      Repository.for(:task).save(@task4)
      @apprenticeship.all_general_tasks.should == [@task4]
    end  
  end

  context "Weekly Feedback" do
    it "should ask the datastore for all of the feedback for a week" do
      Repository.repositories[:feedback] = @feedback_repository
      params = {:author_id => 1, 
                :week => 2,
                :apprenticeship_id => @apprenticeship.id,
                :rating => 5,
                :good => "some text",
                :improve => "some text",
                :change => "some text"}
      feedback = @feedback_repository.new(params)
      feedback2 = @feedback_repository.new(params)
      Repository.for(:feedback).save(feedback)
      Repository.for(:feedback).save(feedback2)
      @apprenticeship.feedback_for_week(2).should == [feedback, feedback2]
    end
  end

  context "Weekly Blog Posts" do
    it "should ask the datastore for all the blog posts for a week" do
      Repository.repositories[:blogpost] = @blogpost_repository
      params = {:apprenticeship_id => @apprenticeship.id,
                :week => 1,
                :title => "Post Title",
                :url => "http://www.example.com"}
      post = @blogpost_repository.new(params)
      post2 = @blogpost_repository.new(params)
      Repository.for(:blogpost).save(post)
      Repository.for(:blogpost).save(post2)
      @apprenticeship.posts_for_week(1).should == [post, post2]
    end
  end

private
  def most_recent_monday
    today = Date.today
    if today.sunday?
      return today - 6
    else
      delta = today.wday - 1
      return Date.today - delta
    end
  end
end
