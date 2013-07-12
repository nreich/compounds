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

### When ###
When /^I go to the page for a batch$/ do
  visit batch_path @batch
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

