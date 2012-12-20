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

Then /^I should see the lot numbers$/ do
    @molecule.batches.each do |batch|
        page.should have_content batch.lot_number
    end
end

