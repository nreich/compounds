### Support ###
def create_molecule(name)
    @molecule = FactoryGirl.create(:molecule, name: name)
end

### Given ###
Given /^I have molecules named (.+)$/ do |names|
    names.split(', ').each do |name|
        FactoryGirl.create(:molecule, name: name)
    end
end

Given /^I have a molecule named (.+)$/ do |name|
    create_molecule(name)
end

Given /^My molecule has batches (.+)$/ do |batches|
    batches.split(', ').each do |batch|
        FactoryGirl.create(:batch, lot_number: batch, molecule: @molecule)
    end
end

### When ###
When /^I go to the list of molecules$/ do
    visit molecules_path
end

When /^I visit my molecule's page$/ do
    visit url_for(@molecule)
end


### Then ###
Then /^I should see "(.+)"$/ do |name|
    page.should have_content name
end



