### Utility Methods ###
def create_batch_for_molecule(molecule) 
  @batch = FactoryGirl.create(:batch, molecule: molecule)
  molecule.batches << @batch
end

def create_batches_for_molecule(molecule, n)
  n.times do
    create_batch_for_molecule(molecule)
  end
end

When /^I visit the show page for the batch$/ do
    @batch = @molecule.batches.first
    visit url_for(@batch)
end

When /^I visit the batch index page$/ do
    visit "/batches"
end

Then /^I should see its' lot number$/ do
    page.should have_content @batch.lot_number
end

Then /^I should see the information for each batch$/ do
  page.should have_css "table#batches"
  batches = Batch.find(:all)
  page.should have_css "tr", count: batches.count + 1
  batches.each do |batch|
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.id.to_s
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.molecule.name
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.lot_number.to_s
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.barcode
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.date.to_s
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.amount.to_s
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.initial_amount.to_s
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.salt.name
    page.should have_css "tr#batch_#{batch.id}",
      text: batch.formula_weight.to_s
  end
end

Then /^I should see a link to the batch show page$/ do
  target_page_path = batch_path @batch
  page.should have_link @batch.id, href: target_page_path
end

Then /^I should see a link to the molecule show page$/ do
  target_page_path = molecule_path @molecule
  page.should have_link @molecule.name, href:target_page_path
end
