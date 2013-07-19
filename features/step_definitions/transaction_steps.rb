### Utility Methods ###
def add_transaction(batch = nil, user = nil)
batch ||= FactoryGirl.create :batch
user ||= FactoryGirl.create :user
@transaction = FactoryGirl.create :transaction, user: user,
                                  batch: batch
end

def remove_all_transactions(batch)
  transactions = Transaction.where "batch_id = ?", batch.id
  unless transactions.size == 0
    transactions.each { |transaction| transaction.destroy }
  end
end

def remove_user_transactions(user)
  transactions = Transaction.where "user_id = ?", user.id
  unless transactions.size == 0
    transactions.each { |transaction| transaction.destroy }
  end
end

### When ###
When /^I enter a valid amount$/ do
  page.fill_in 'Amount', with: (@batch.amount / 2)
  click_button 'Submit'
end

When /^I enter an amount larger than that in the batch$/ do
  page.fill_in 'Amount', with: (@batch.amount * 2)
end

### Then ###
Then /^my transaction is created$/ do
  expect(Transaction.last.user).to eq(@user)
end

Then /^the amount remaining in the batch is updated$/ do
  @batch.reload
  expect(@batch.amount < @batch.initial_amount).to be_true
end

Then /^I remain on the new transaction page$/ do
  expect(current_path).to eq(new_transaction_path)
end

Then /^my transaction is not created$/ do
  expect(Transaction.last).to be_nil
end
#### Utility Methods ###
#def create_transactions_for_user(user, n)
#  n.times do
#    create_molecule
#    create_batch_for_molecule(@molecule)
#    create_transaction
#  end
#end
#
#def create_transaction
#  @transaction = FactoryGirl.create(:transaction, user: @user,
#                                                  batch: @batch)
#end
#
#
#### Given ###
#Given /^My batch has a transaction$/ do
#  create_user
#  @batch = @molecule.batches.first
#  create_transaction
#end
#
#### When ###
#When /^I visit the transaction's show page$/ do
#  visit url_for(@transaction)
#end
#
#### Then ###
#Then /^I should see the transaction amount$/ do
#  page.should have_content @transaction.amount
#end
#
#Then /^I should see the transaction's batch number$/ do
#  page.should have_content @transaction.batch.lot_number
#end
#
#Then /^I should see the transaction's molecule name$/ do
#  page.should have_content @transaction.batch.molecule.name
#end
#
#Then /^I should see the name of the user that made the transaction$/ do
#  page.should have_content @transaction.user.name
#end
#
#Then /^I should see when the transaction occured$/ do
#  page.should have_content @transaction.created_at
#end
