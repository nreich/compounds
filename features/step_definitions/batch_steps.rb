When /^I visit the show page for the batch$/ do
    batch = @molecule.batches.first
    visit url_for(batch)
end

When /^I visit the batch index page$/ do
    visit "/batches"
end


