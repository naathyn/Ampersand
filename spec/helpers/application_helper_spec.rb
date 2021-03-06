require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the page name" do
      full_title("amp").should =~ /&mpersand/
    end

    it "should include the base name" do
      full_title("amp").should =~ /&mpersand/
    end

    it "should not include a bar without page title" do
      full_title("").should_not =~ /\|/
    end
  end
end
