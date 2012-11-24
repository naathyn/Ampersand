require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do

    let(:user) { FactoryGirl.create(:user) }
    before { visit root_path }

    it { should have_selector('div.alert.alert-info') }
    it { should have_selector('h1', text: 'Ampersand') }
    it { should_not have_selector('title', text: full_title("@#{user.name}")) }

    describe "for signed-in users" do
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it { should_not have_selector('h1', text: 'Ampersand') }
      it { should have_selector('title', text: full_title("@#{user.name}")) }
      it { should have_selector('.gravatar', href: user_path(user)) }
      it { should have_link("#{user.name}", href: '#') }

      it "should show user shares" do
        user.share.each do |item|
          page.should have_selector("div##{item.id}", text: item.content)
        end
      end

      it "should be able to show members page when signed in" do
        click_link "Members"
        page.should have_selector('title', text: full_title('Members'))
      end

      describe "when a user likes or follows" do
        let(:other_user) { FactoryGirl.create(:user) }
        let(:second_micropost) { FactoryGirl.create(:micropost, user: other_user, content: "Lorem ipsum") }
        before do
          other_user.follow!(user)
          user.like!(second_micropost)
          visit root_path
        end

        it "should have the correct information" do
          page.should have_link("2 shares", href: user_path(user))
          page.should have_link("0 following", href: following_user_path(user))
          page.should have_link("1 followers", href: followers_user_path(user))
          page.should have_selector('strong', text: "1")
          page.should have_selector('strong', text: "0")
        end
      end
    end
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h2', text: 'Background') }
    it { should have_selector('title', text: full_title('About')) }
  end

  it "should have the correct layout" do
    visit root_path
    click_link "Members"
    page.should have_selector('div.alert.alert-notice')
    page.should have_selector 'title', text: full_title('Sign in')
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
  end
end
