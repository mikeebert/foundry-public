require 'spec_helper'
require 'repository'

#Repositories for Memory
 require 'user'
 require 'apprenticeship'
 require 'task'
 require 'feedback'
 require 'blog_post'
#Memory models
 require 'models/blog_post'
 require 'models/user'
 require 'models/feedback'
 require 'models/apprenticeship'
 require 'models/task'



describe "Foundry" do

  def app
    @app ||= Foundry
  end

  before(:each) do
    setup_fresh_repositories
  end

  it "should load the home page" do
    get "/"
    last_response.should be_ok
  end

  describe "login & logout pages" do
    it "should load the login page" do
      get "/login"
      last_response.should be_ok
    end
  end

  describe "User pages" do
    before(:each) do
      @user = Memory::User.new(:name => "Test",
                               :email => "test@test.com")
    end

    it "should load the users/new page" do
      get "/users/new"
      last_response.should be_ok
    end

    it "should create a new user and send it to the datastore" do
      user_datastore = MemoryDatastore::User

      Repository.should_receive(:for).twice.and_return(user_datastore)
      user_datastore.should_receive(:new).and_return(@user)
      user_datastore.should_receive(:save).and_return(@user)

      post "/users"
    end

    it "should load the users show page" do
      Repository.for(:user).save(@user)
      login_as @user
      get "/users/1"
      last_response.should be_ok
    end

    it "should load the users index page for an admin" do
      @user.admin = true
      Repository.for(:user).save(@user)
      login_as @user
      get "/users"
      last_response.should be_ok
    end

    it "should not load the users index page for a non-admin" do
      Repository.for(:user).save(@user)
      login_as @user
      get "/users"
      last_response.should_not be_ok
    end
  end

  describe "A user's apprenticeship pages" do
    before(:each) do
      @user = Memory::User.new(:name => "Test", 
                               :email => "test@test.com")
      Repository.for(:user).save(@user)

      @apprenticeship = Memory::Apprenticeship.new(:apprentice_id => 1,
                                                   :mentor_id => 1,
                                                   :start_date => Date.today,
                                                   :end_date => Date.today)

      login_as @user
    end

    it "should load the apprenticeship checklist" do
      get "/apprenticeships/checklist"
      last_response.should be_ok
    end

    it "should load the apprenticeships index page for an admin" do
      @user.admin = true
      login_as @user

      datastore = mock(MemoryDatastore::Apprenticeship)
      Repository.should_receive(:for).and_return(datastore)
      datastore.should_receive(:all).and_return(Array.new)

      get "/apprenticeships"
      last_response.should be_ok
    end

    it "should load the apprenticeships/new page" do
      login_as @user 
      get "/apprenticeships/new"
      last_response.should be_ok
    end

    it "should post an apprenticeship and send it to the datastore" do
      post "/apprenticeships", {:apprentice_id => 1, 
                                :mentor_id => 1, 
                                :start_date => "01/01/2012",
                                :end_date => "12/31/2012"}
      apprenticeship = Repository.for(:apprenticeship).find_by_id(1)
      apprenticeship.apprentice_id.should == 1
      apprenticeship.mentor_id.should == 1

      last_response.should be_ok
    end

    it "should load a specific apprenticeship" do
      Repository.for(:apprenticeship).save(@apprenticeship)
      login_as @user
      get "/apprenticeships/1"
      last_response.should be_ok
    end

    context "An Apprenticeship" do   
      before(:each) do
        @apprenticeship = Memory::Apprenticeship.new(:start_date => (Date.today - 10),
                                                     :end_date => Date.today,
                                                     :apprentice_id => 1,
                                                     :mentor_id => 1)
        @apprenticeship.id = 1
        Repository.for(:apprenticeship).save(@apprenticeship)
        login_as @user
      end

      it "should load the page for the week of an apprenticeship" do
        get "/apprenticeships/1/weeks/1"
        last_response.should be_ok
      end

      context "Tasks" do
        it "should load the page to add a new weekly task" do
          get "/apprenticeships/1/weeks/1/tasks/new"
          last_response.should be_ok
        end

        it "should load the task show page" do
          task = Memory::Task.new
          task.week = 1
          Repository.for(:task).records[1] = task
          get "apprenticeships/1/weeks/1/tasks/1"
          last_response.should be_ok
        end

        context "Task CRUD" do
          before(:each) do
            @task = Repository.for(:task).new(:apprenticeship_id => 1, :week => 1, :title => "some title")
            @task_datastore = Repository.for(:task)
          end

          it "should send a new task to the datastore to save it" do
            Repository.should_receive(:for).twice.and_return(@task_datastore)
            @task_datastore.should_receive(:new).and_return(@task)
            @task_datastore.should_receive(:save).with(@task)

            post "/tasks"
          end

          it "should ask the datastore for an apprenticeship and a task and then load the edit task page" do
            Repository.for(:task).save(@task)

            get "/apprenticeships/1/tasks/1/edit"
            last_response.should be_ok
          end

          it "should locate a task and tell it update itself" do
            Repository.should_receive(:for).and_return(@task_datastore)
            @task_datastore.should_receive(:find_by_id).and_return(@task)
            @task.should_receive(:update)

            put "/tasks/1"
          end

          it "should locate a task and tell the datastore to delete it" do
            @task_datastore.save(@task)
            @task_datastore.all.should include(@task)

            delete "/tasks/#{@task.id}"
            @task_datastore.all.should_not include(@task)
          end

        end

      end

      context "Feedback" do
        it "should load the new feedback page" do
          get 'apprenticeships/1/weeks/1/feedback/new'
          last_response.should be_ok
        end

        it "should load the feedback show page" do
          get "apprenticeships/1/weeks/1/feedback"
          last_response.should be_ok
        end

        it "should send a feedback to the datastore" do
          params = {:author_id => 1,
                    :rating => 3,
                    :apprenticeship_id => 1,
                    :week => 1,
                    :good => "Good", 
                    :improve => "stuff",
                    :change => "other stuff"}

          post "/feedback", params

          feedback =  Repository.for(:feedback).find_by_id(1)
          feedback.author_id.should == params[:author_id]
          feedback.rating.should == params[:rating]
          feedback.apprenticeship_id.should == params[:apprenticeship_id]
          feedback.week.should == params[:week]
          feedback.good.should == params[:good]
          feedback.improve.should == params[:improve]
          feedback.change.should == params[:change]

          last_response.should be_redirect
          last_response.location.should include '/apprenticeships'
        end

        it "should render the new feedback form with errors for invalid feedback" do
          post "/feedback", {:apprenticeship_id => 1, :week => 1}
          last_response.should be_ok
          last_response.body.should include 'Author_id is required'
          last_response.body.should include 'Rating is required'
          last_response.body.should include 'Good is required'
          last_response.body.should include 'Improve is required'
          last_response.body.should include 'Change is required'
        end
      end

      context "Weekly Blog Posts" do
        it "should load the new post page" do
          get '/blogpost/new/1/1'
          last_response.should be_ok
        end

        it "should send a new post item to the datastore" do
          blogpost_datastore = Repository.for(:blogpost)
          post = Repository.for(:blogpost).new(:title => "Some title", 
                                               :url => "http://www.test.com", 
                                               :week => 1,
                                               :apprenticeship_id => 1)

          Repository.should_receive(:for).twice.and_return(blogpost_datastore)
          blogpost_datastore.should_receive(:new).and_return(post)
          blogpost_datastore.should_receive(:save).with(post)

          post '/blogpost'
          last_response.should be_redirect
          last_response.location.should include '/apprenticeships'
        end

        it "should redirect to a new blogpost if the post isn't valid" do
          post '/blogpost', {:apprenticeship_id => 1}

          last_response.body.should include 'Title is required'
          last_response.body.should include 'Url is required'
        end
      end

    end
  end
private

  def setup_fresh_repositories
    {:user => MemoryDatastore::User.new,
     :apprenticeship => MemoryDatastore::Apprenticeship.new,
     :task => MemoryDatastore::Task.new, 
     :feedback => MemoryDatastore::Feedback.new,
     :blogpost => MemoryDatastore::Blogpost.new
    }.each do |type, repo|
      Repository.register(type, repo)
     end
  end
end
