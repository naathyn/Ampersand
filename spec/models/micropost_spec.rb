require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it { should respond_to(:to) }

  it { should respond_to(:opinions) }
  it { should respond_to(:likes) }
  it { should respond_to(:fans) }

  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id nor to_id" do
      expect do
        Micropost.new(user_id: user.id, to_id: user.id, content: "muaha")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 256 }
    it { should_not be_valid }
  end

  describe "the replies process" do

    let(:recipient) { FactoryGirl.create(:user_reply) }
    before { @micropost = user.microposts.create(content: "@#{recipient.name} hey!") }

    it "should match the to_id to the recipient (user)" do
      @micropost.to.should == recipient
    end
  end
end
