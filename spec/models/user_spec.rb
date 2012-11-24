require 'spec_helper'

describe User do

  before do
    @user = User.new(realname: "Nathan Couch", email: "nathan3k@gmail.com", name: "naathyn", password: "secret", password_confirmation: "secret")
    @recipient = User.new(realname: "Alan Couch", email: "hatchiebird@gmail.com", name: "hatchiebird", password: "secret", password_confirmation: "secret")
  end

  subject { @user }

  it { should respond_to(:realname) }
  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should respond_to(:location) }
  it { should respond_to(:bio) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:captchas) }
  it { should respond_to(:microposts) }
  it { should respond_to(:replies) }
  it { should respond_to(:fans) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:captcha) }
  it { should respond_to(:share) }
  it { should respond_to(:profile) }
  it { should respond_to(:atreply) }
  it { should respond_to(:followers) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }
  it { should respond_to(:liked?) }
  it { should respond_to(:like!) }
  it { should respond_to(:unlike!) }

  it { should be_valid }
  it { should_not be_admin }

  describe "accessible attributes" do
    it "should not allow access to admin" do
      expect do
        User.new(admin: true)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "with admin attribute toggled" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when full name is not present" do
    before { @user.realname = " " }
    it { should_not be_valid }
  end

  describe "when full name is too long" do
    before { @user.realname = "a" * 21 }
    it { should_not be_valid }
  end

  describe "when full name is too short" do
    before { @user.realname = "a" * 1 }
    it { should_not be_valid }
  end

  describe "when full name is already taken" do
    before do
      user_with_same_realname = @user.dup
      user_with_same_realname.realname = @user.realname.upcase
      user_with_same_realname.save
    end

    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when an email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email addresses with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "when username is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.name = "a" * 16 }
    it { should_not be_valid }
  end

  describe "when username is too short" do
    before { @user.name = "a" * 4 }
    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.name = @user.name.upcase
      user_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "username with mixed case" do
    let(:mixed_case_name) { "NaAtHyN" }

    it "should be saved as all lower-case" do
      @user.name = mixed_case_name
      @user.save
      @user.reload.name.should == mixed_case_name.downcase
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "a location that's too long" do
    before { @user.location = "a" * 51 }
    it { should_not be_valid }
  end

  describe "a bio that's too long" do
    before { @user.bio = "a" * 256 }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_name(@user.name) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_with_invalid_password) { found_user.authenticate("wrong") }

      it { should_not == user_with_invalid_password }
      specify { user_with_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "all the different feeds" do
    before { @user.save }

    let!(:older_share) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_share) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right shares in the right order" do
      @user.microposts.should == [newer_share, older_share]
    end
  
    it "should destroy related shares" do
      microposts = @user.microposts.dup
      @user.destroy
      microposts.should_not be_empty
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
  
    describe "user shares (main feed)" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      let(:followed_user) { FactoryGirl.create(:user) }

      before do
        @user.follow!(followed_user)
        3.times { followed_user.microposts.create!(content: "Lorem ipsum") }
      end

      its(:share) { should include(newer_share) }
      its(:share) { should include(older_share) }
      its(:share) { should_not include(unfollowed_post) }
      its(:share) do
        followed_user.microposts.each do |share|
          should include(share)
        end
      end
    end

    describe "profile feed" do
      let(:own_share) do
        FactoryGirl.create(:micropost, user: @user)
      end

      let(:followed_user) { FactoryGirl.create(:user) }

      let(:other_share) do
        FactoryGirl.create(:micropost, user: followed_user)
      end

      before do
        @user.follow!(followed_user)
        3.times { @user.microposts.create!(content: "Lorem ipsum") }
      end

      its(:profile) { should include(newer_share) }
      its(:profile) { should include(older_share) }
      its(:profile) { should include(own_share) }
      its(:profile) { should_not include(other_share) }
      its(:profile) do
        @user.microposts.each do |share|
          should include(share)
        end
      end
    end

    describe "atreply feed" do
      let(:replier) { FactoryGirl.create(:user) }

      let!(:older_reply) do
        FactoryGirl.create(:micropost, user: replier, content: "@#{@user.name}", created_at: 1.day.ago)
      end
      let!(:newer_reply) do
        FactoryGirl.create(:micropost, user: replier, content: "@#{@user.name}", created_at: 1.hour.ago)
      end

      before do
        3.times { replier.microposts.create!(content: "@#{@user.name}") }
      end

      let(:non_reply) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      its(:atreply) { should include(newer_reply) }
      its(:atreply) { should include(older_reply) }
      its(:atreply) { should_not include(non_reply) }
      its(:atreply) do
        @user.microposts.each do |own_post|
          should_not include(own_post)
        end
      end
    end
  end

  describe "replies for the atreply feed" do
    before do
      @recipient = FactoryGirl.create(:user_reply)
    end

    it "should set to_id to self" do
      @user.save
      reply = @user.microposts.create(content:"@hatchiebird hey!")
      reply.to.should == @recipient
      @recipient.replies.should == [reply]
    end
  end

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end

    describe "and unfollowing" do
      before { @user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end

  describe "liking" do
    let(:random_share) { FactoryGirl.create(:micropost) }
    before do
      @user.save
      @user.like!(random_share)
    end
    it { should be_liked(random_share) }

    describe "liked share" do
      subject { random_share }
      its(:fans) { should include(@user) }
    end

    describe "and unliking" do
      before { @user.unlike!(random_share) }
      it { should_not be_liked(random_share) }
      its(:fans) { should_not include(random_share) }
    end
  end
end
