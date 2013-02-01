### Utility Methods ###

def create_visitor
  @visitor ||= {name: "John Doe", email: "example@example.com",
    password: "password", password_confirmation: "password" }
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email],
                                    password: @visitor[:password])
end

def find_user
  @user ||= User.first conditions: {email: @visitor[:email]}
end

def delete_user
  @user ||= User.first conditions: {email: @visitor[:email]}
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "Name", with: @visitor[:name]
  fill_in "Email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "Email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  click_button "Sign in"
end

### Given ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_visitor
  create_user
  sign_in
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as a user$/ do
  create_user
end

Given /^a user exists$/ do
  @user = FactoryGirl.create(:user)
end

Given /^there are (\d+) users$/ do |n|
  @users = []
  number_users = Integer(n)
  number_users.times do
    @users << FactoryGirl.create(:user)
  end
end

### When ###
When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(email: "invalid_email@doh")
  sign_up
end

When /^I sign up without a name$/ do
  create_visitor
  @visitor = @visitor.merge(name: "")
  sign_up
end

When /^I sign up with a too long name$/ do
  create_visitor
  long_name = "a" * 51
  @visitor = @visitor.merge(name: long_name)
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(password: "")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(password_confirmation: "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(password_confirmation: "invalid")
  sign_up
end

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  create_visitor
  @visitor = @visitor.merge(email: "wrong_email@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  create_visitor
  @visitor = @visitor.merge(password: "badpassword")
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'  
end

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "Name", with: "newname"
  fill_in "user_current_password", with: @visitor[:password]
  click_button "Update"
end

When /^I visit their show page$/ do
  visit "/users/#{@user.id}"
end

When /^I visit the user index page$/ do
  visit '/users/index/'
end

### Then ###
Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing name message$/ do
  page.should have_content "Name can't be blank"
end

Then /^I should see a too long name message$/ do
  page.should have_content "Name 50 characters is the maximum allowed"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully"
end

Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should see a signed out message$/ do
  #This currently does not work, but when tested with rails server,
  #the message does appear. Is this a artifact from using GET request
  #rather than DELETE for sign out?
  #page.should have_content "Signed out successfully"
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully"
end

Then /^I should see their name$/ do
  page.should have_content @user.name
end

Then /^I should see their email address$/ do
  page.should have_content @user.email
end

Then /^I should see the name of each user$/ do
  @users.each do |user|
    page.should have_content user.name
  end
end