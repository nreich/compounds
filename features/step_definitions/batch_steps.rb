### Utility Methods ###
def create_batch(molecule = nil)
  molecule ||= FactoryGirl.create(:molecule)
  @batch = FactoryGirl.create(:batch, molecule: molecule)
  molecule.batches << @batch
end

### Given ###
Given /^there are any transactions for a batch$/ do
  create_batch
  add_transaction(@batch)
end

Given /^there are no transactions for a batch$/ do
  create_batch
  remove_all_transactions(@batch)
end

Given /^the batch I want exists$/ do
  create_batch
end

### When ###
When /^I go to the page for a batch$/ do
  visit batch_path @batch
end

When /^I click the add transaction link$/ do
  click_link "Add transaction"
end

When /^I go to the batch index$/ do
  visit batches_path
end

When /^I click the link to destroy the batch$/ do
  click_link "Destroy"
end

When /^I click the link to edit the batch$/ do
  click_link "Edit"
end

When /^I edit its barcode$/ do
  fill_in "Barcode", with: "new barcode"
  click_button "Submit"
end

### Then ###
Then /^I see a table with its transactions$/ do
  expect(page).to have_css 'h2', text: 'Transactions'
  expect(page).to have_css 'table#transactions'
end

Then /^I do not see a table of transactions$/ do
  expect(page).to have_no_css 'table#transactions'
end

Then /^I see a note that this batch has no transactions$/ do
  expect(page).to have_css 'p',
    text: 'There are not yet any transactions for this batch'
end

Then /^I am redirected to the page of the batch$/ do
  expect(current_path).to eq(batch_path @batch)
end

Then /^the batch no longer exists$/ do
  expect{ Batch.find(@batch) }.to raise_error(
    ActiveRecord::RecordNotFound)
end

Then /^the batch's barcode gets changed$/ do
  old_barcode = @batch.barcode
  expect(Batch.find(@batch).barcode).to_not eq(old_barcode)
end 
