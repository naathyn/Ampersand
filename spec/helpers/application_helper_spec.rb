require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the page name" do
      full_title("amp").should =~ /&mpersand/
    end

    it "should include the base name" do
      full_title("A Social Platform in development").should =~ /&mpersand/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end
end
