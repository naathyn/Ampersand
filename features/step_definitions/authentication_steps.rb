Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^he submits invalid signin information$/ do
  click_button "Sign in"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = User.create(realname: "Nathan Couch", email: "naathyn@gmail.com", name: "naathyn", password: "secret", password_confirmation: "secret")
end

When /^the user submits valid signin information$/ do
  visit signin_path
  fill_in "Username", with: @user.name
  fill_in "Password", with: @user.password 
  click_button "Sign in"
end

Then /^he should see his profile page$/ do
  page.should have_selector('title', text: @user.realname)
end

Then /^he should see a signout link$/ do
  page.should have_link('Sign out', href: signout_path)
end
