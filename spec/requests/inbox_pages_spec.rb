require 'spec_helper'

describe "Inbox" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  describe "not being signed in" do
    before { visit inbox_path }
    it { should have_selector('div.alert.alert-notice') }
    it { should have_selector 'title', text: "Sign in" }
  end

  describe "creating a message" do
    before do
      sign_in user
      visit inbox_path
    end

    it { should have_selector 'title', text: "!#{user.name}" }

    describe "with invalid information" do

      it "should not create a message" do
        expect { click_button "Send" }.not_to change(Message, :count)
      end

      describe "error messages" do
        before { click_button "Send" }
        it { should have_content('error') }
      end

    describe "with an invalid conversation" do

      before do
        fill_in 'message_convo', with: "Lorem ipsum"
        click_button "Send"
      end
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'message_convo', with: "!#{user.name} Lorem ipsum" }

      it "should send the message and increase message count" do
        expect { click_button "Send" }.to change(Message, :count).by(1)
      end
    end
  end
end
