require 'spec_helper'

describe Captcha do

  let(:user) { FactoryGirl.create(:user) }
  before { @captcha = user.captchas.build(content: "My first captcha!") }

  subject { @captcha }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }

  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Captcha.new(user_id: user.id, content: "muaha")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @captcha.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @captcha.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @captcha.content = "a" * 181 }
    it { should_not be_valid }
  end
end
