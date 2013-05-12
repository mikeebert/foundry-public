require 'helpers/tag_helper'

describe TagHelper do
  it "should return an array of sorted integers" do
    TagHelper.format_tags(["2", "3", "1"]).should == [1,2,3]
  end
end
