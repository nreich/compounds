### Utilty Methods ###
def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email],
                                    password: @visitor[:password])
end

def create_visitor
  @visitor ||= {name: "John Doe", email: "example@example.com",
    password: "password", password_confirmation: "password" }
end

def delete_user
  @user ||= User.first conditions: {email: @visitor[:email]}
  @user.destroy unless @user.nil?
end

def edit_account_name(name)
  @new_name = name
  click_link "Edit account"
  fill_in "Name", with: @new_name
  fill_in "user_current_password", with: @visitor[:password]
  click_button "Update"
end

def find_user
  @user ||= User.first conditions: {email: @visitor[:email]}
end

def on_sign_in_page?
  expect(page).to have_css 'form#new_user'
  expect(page).to have_css 'h2', text: 'Sign in'
end

def sign_in
  visit '/users/sign_in'
  fill_in "Email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  click_button "Sign in"
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "Name", with: @visitor[:name]
  fill_in "Email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
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

Given /^I am already a user$/ do
  create_visitor
  create_user
end

### When ###
When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with invalid data$/ do
  create_visitor
  visit '/users/sign_up'
  fill_in "Name", with: ""
  fill_in "Email", with: ""
  fill_in "user_password", with: ""
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
end

When /^I edit my account details$/ do
  edit_account_name("newname")
end

When /^I edit my account but enter invalid information$/ do
  edit_account_name("")
end

When /^I visit the homepage$/ do
  visit "/"
end

When /^I sign in with valid credentials$/ do
  sign_in
end

When /^I return to the site$/ do
  visit '/'
end

When /^I try to sign in with an invalid email and password$/ do
  visit '/users/sign_in'
  fill_in "Email", with: "invalid_email@example.com" 
  fill_in "user_password", with: "badpassword"
  click_button "Sign in"
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

### Then ###
Then /^I should successfully become a user$/ do
  expect(User.first(conditions: {email: @visitor[:email]})).to be_true
end

Then /^I should be redirected to the homepage$/ do
  expect(current_path).to  eq("/")
end

Then /^I should see a successful sign up message$/ do
  expect(page).to have_css '#flash_notice', 
    text: "Welcome! You have signed up successfully."
end
  
Then /^I should not become a user$/ do
  expect(User.first(conditions: {email: @visitor[:email]})).to be_false
end

Then /^I should see a message about why I failed to sign up$/ do
  expect(page).to have_css '#error_explanation', text: "Name can't be blank"
  expect(page).to have_css '#error_explanation', text: "Email can't be blank"
  expect(page).to have_css '#error_explanation', text: "Password can't be blank"
end

Then /^I should see an account edited message$/ do
  expect(page).to have_css '#flash_notice',
    text: 'You updated your account successfully'
end

Then /^my account details should have changed$/ do
  edited_user = User.first conditions: {email: @visitor[:email]}
  expect(edited_user.name).to eq(@new_name)
end

Then /^I should see a message about what I entered wrong$/ do
  expect(page).to have_css '#error_explanation', text: "Name can't be blank"
end

Then /^I should still see the account editing form$/ do
  expect(page).to have_css 'form#edit_user'
end

Then /^my account details should not have changed$/ do
  failed_to_edit_user = User.first conditions: {email: @visitor[:email]}
  expect(failed_to_edit_user.name).to eq(@visitor[:name])
end

Then /^I should be redirected to the sign in page$/ do
  on_sign_in_page?
end

Then /^I see a successful sign in message$/ do
  expect(page).to have_css '#flash_notice', text: "Signed in successfully"
end

Then /^I am redirected to the homepage$/ do
  expect(current_path).to eq("/")
end

Then /^I should be signed in$/ do
  expect(page).to have_link "Logout", href: "/users/sign_out"
  expect(page).to have_no_link "Login", href: "/users/sign_in"
  expect(page).to have_no_link "Sign up", href: "users/sign_up"
end

Then /^I should see an invalid login message$/ do
  expect(page).to have_css '#flash_alert',
    text: "Invalid email or password."
end

Then /^I should still be on the sign in page$/ do
  on_sign_in_page?
end

Then /^I should be signed out$/ do
  visit '/'
  on_sign_in_page?
end
