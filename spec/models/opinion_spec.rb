require 'spec_helper'

describe Opinion do

  let(:user) { FactoryGirl.create(:user) }
  let(:micropost) { FactoryGirl.create(:micropost) }

  let(:opinion) { user.opinions.build(like_id: micropost.id) }

  subject { opinion }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to fan_id (user)" do
      expect do
        Opinion.new(fan_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "likes and fans" do
    it { should respond_to(:fan) }
    it { should respond_to(:like) }
    its(:fan_id) { should == user.id }
    its(:like_id) { should == micropost.id }
  end

  describe "when fan_id is not present" do
    before { opinion.fan_id = nil }
    it { should_not be_valid }
  end

  describe "when like_id is not present" do
    before { opinion.like_id = nil }
    it { should_not be_valid }
  end
end
