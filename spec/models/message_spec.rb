require 'spec_helper'

describe Message do

  let(:user) { FactoryGirl.create(:user) }
  let(:recipient) { FactoryGirl.create(:user) }
  before { @message = user.messages.create(convo: "!#{recipient.name} hey!") }

  subject { @message }

  it { should respond_to(:convo) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it { should respond_to(:to) }

  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id nor to_id" do
      expect do
        Message.new(user_id: user.id, to_id: user.id, content: "muaha")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @message.user_id = nil }
    it { should_not be_valid }
  end

  describe "with a blank conversation" do
    before { @message.convo = " " }
    it { should_not be_valid }
  end


  describe "with a conversation that is too long" do
    before { @message.convo = "a" * 256 }
    it { should_not be_valid }
  end

  describe "the messaging process" do

    it "should match the to_id to the recipient (user)" do
      @message.to.should == recipient
    end
  end
end
