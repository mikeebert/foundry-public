require 'helpers/date_helper'

describe DateHelper do
  it "should format a text date" do
    date = Date.new(2012,12,25)
    DateHelper.format("12/25/2012").should == date
  end  
end
