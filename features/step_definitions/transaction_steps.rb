### Given ###
Given /^My batch has a transaction$/ do
  create_user
  @transaction = FactoryGirl.create(:transaction, user: @user, batch: @batch)
end

### When ###
When /^I visit the transaction's show page$/ do
  visit url_for(@transaction)
end

### Then ###
Then /^I should see the transaction amount$/ do
  page.should have_content @transaction.amount
end

Then /^I should see the transaction's batch number$/ do
  page.should have_content @transaction.batch.lot_number
end

Then /^I should see the transaction's molecule name$/ do
  page.should have_content @transaction.batch.molecule.name
end

Then /^I should see the name of the user that made the transaction$/ do
  page.should have_content @transaction.user.name
end

Then /^I should see when the transaction occured$/ do
  page.should have_content @transaction.created_at
end
