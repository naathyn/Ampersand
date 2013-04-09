require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Share" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Share" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Share" }.to change(Micropost, :count).by(1)
      end
    end

    describe "when a user shares a link (email or url)" do

      before { fill_in 'micropost_content', with: Faker::Internet.email }

      it "should create a micropost with a clickable link" do
        expect { click_button "Share" }.to change(Micropost, :count).by(1)
      end

      its(:html) { should match('...</a>') }
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "Delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "user privileges (well-footer links)" do

    before { FactoryGirl.create(:micropost, user: user) }

    describe "as user" do
      before { sign_in user }

      it { should_not have_selector('form', value: "Like") }
      it { should_not have_selector('form', value: "Reply") }
      it { should have_link "Delete" }
    end

      describe "as non-user" do
        let(:new_user) { FactoryGirl.create(:user) }
        before do
          sign_in new_user
          visit root_path
        end

      it { should have_selector('form', value: "Like") }
      it { should have_selector('form', value: "Reply") }
      it { should_not have_link "Delete" }
    end
  end
end
