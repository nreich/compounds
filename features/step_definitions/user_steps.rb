### Utility Methods ###

def create_visitor
  @visitor ||= {name: "John Doe", email: "example@example.com",
    password: "password", password_confirmation: "password" }
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

### Given ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
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
