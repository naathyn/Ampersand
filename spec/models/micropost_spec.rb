require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
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
    before { @micropost.content = "x" * 201 }
    it { should_not be_valid }
  end

		describe "from_users_followed_by" do

    before(:each) do
      @fail_user = FactoryGirl.create(:user, email: FactoryGirl.generate(:email))
      @megafail_user = FactoryGirl.create(:user, email: FactoryGirl.generate(:email))

      @user_post = @user.microposts.create!(content: "oh")
      @fail_post = @fail_user.microposts.create!(content: "em")
      @megafail_post = @megafail_user.microposts.create!(content: "gee")

      @user.follow!(@fail_user)
    end

    it "should have a from_users_followed_by class method" do
      Micropost.should respond_to(:from_users_followed_by)
    end

    it "should include the followed user's microposts" do
      Micropost.from_users_followed_by(@user).should include(@fail_post)
    end

    it "should include the user's own microposts" do
      Micropost.from_users_followed_by(@user).should include(@fail_post)
    end

    it "should not include an unfollowed user's microposts" do
      Micropost.from_users_followed_by(@user).should_not include(@megafail_post)
    end
  end

  describe "from_users_followed_by_including_replies" do

     before(:each) do
       @fail_user = FactoryGirl.create(:user, email: FactoryGirl.generate(:email))
       @megafail_user = FactoryGirl.create(:user, email: FactoryGirl.generate(:email))

       @user_post = @user.microposts.create!(content: "oh")
       @fail_post = @fail_user.microposts.create!(content: "em")
       @megafail_post = @megafail_user.microposts.create!(content: "gee")
       
       @userReply = FactoryGirl.create(:userReply)
       @ultfail_post = @megafail_user.microposts.create!(content: "@#{@userReply.romania} gee")
       
       @user.follow!(@fail_user)
     end

     it "should have a from_users_followed_by class method" do
       Micropost.should respond_to(:from_users_followed_by_including_replies)
     end

     it "should include the followed user's microposts" do
       Micropost.from_users_followed_by_including_replies(@user).should include(@fail_post)
     end

     it "should include the user's own microposts" do
       Micropost.from_users_followed_by_including_replies(@user).should include(@user_post)
     end

     it "should not include an unfollowed user's microposts" do
       Micropost.from_users_followed_by_including_replies(@user).should_not include(@megafail_post)
     end
     
     it "should include posts to user" do
       Micropost.from_users_followed_by_including_replies(@userReply).should include(@ultfail_post)
     end
   end

  describe "replies" do
    before(:each) do
      @reply_to_user = FactoryGirl.create(:userReply)
      @micropost = @user.microposts.create(content: "@lady_gaga Lorem ipsum")
    end

    it "should identify a @user and set the in_reply_to field accordingly" do
      @micropost.to.should == @reply_to_user
    end
	end
end
