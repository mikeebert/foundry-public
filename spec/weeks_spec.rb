require 'weeks'
require 'date'
require 'mocks/mock_apprenticeship'
require 'datastore/memory_datastore/models/apprenticeship'

describe "Weeks model" do

  it "should return a hash of weeks for an apprenticeship lasting one day" do
    Weeks.apprenticeship_weeks(Date.today, Date.today).should == {1 => Date.today}
  end

  it "should return a hash of weeks for an apprenticeship lasting 8 days" do
    Date.stub(:today).and_return(Date.new(2012,8,31))
    Weeks.apprenticeship_weeks(Date.today, (Date.today + 8)).should == {1 => Date.today,
                                                                        2 => (next_monday)}
  end

  it "should return a hash of weeks for an apprenticeship spanning three weeks" do
    Date.stub(:today).and_return(Date.new(2012,8,31))
    Weeks.apprenticeship_weeks(Date.today, (Date.today + 15)).should == {1 => Date.today, 
                                                                        2 => next_monday,
                                                                        3 => (next_monday + 7)}
  end

  it "should return a hash with the week number and date object" do
    start_date = Date.new(2012,06,01)
    end_date = Date.new(2012,7,5)
    Weeks.apprenticeship_weeks(start_date, end_date).should == {1 => start_date,
                                                                2 => Date.new(2012,6,4),
                                                                3 => Date.new(2012,6,11),
                                                                4 => Date.new(2012,6,18),
                                                                5 => Date.new(2012,6,25),
                                                                6 => Date.new(2012,7,2)}
  end

  it "should return weeks for an apprenticeship starting on a Sunday" do
    start_date = Date.new(2012,7,1)
    end_date = Date.new(2012,7,15)
    Weeks.apprenticeship_weeks(start_date, end_date).should == {1 => Date.new(2012,7,1),
                                                                2 => Date.new(2012,7,2),
                                                                3 => Date.new(2012,7,9)}
  end
  
  it "should return the final week for an apprenticeship ending on a Monday" do
    start_date = Date.new(2012,7,1)
    end_date = Date.new(2012,7,16)
    Weeks.apprenticeship_weeks(start_date, end_date).should == {1 => Date.new(2012,7,1),
                                                                2 => Date.new(2012,7,2),
                                                                3 => Date.new(2012,7,9),
                                                                4 => Date.new(2012,7,16)}
  end

  it "should return the most recent monday" do
    Weeks.most_recent_monday.should == next_monday - 7
  end
  
  it "should return true if a week includes the current date" do
    Weeks.this_week_includes(Date.today).should == true
  end

  it "should not say that the following Monday is included in a week" do
    Weeks.this_week_includes(next_monday).should == false
  end

private
  def next_monday
    Date.today.sunday? ? (Date.today + 1) : (Date.today + (8 - Date.today.wday))
  end
end
