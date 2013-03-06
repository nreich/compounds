### Support ###
def create_molecule
    @molecule = FactoryGirl.create(:molecule)
end

def create_molecules(n)
  @molecules = []
  n.times do
    molecule = FactoryGirl.create(:molecule)
    @molecules << molecule
  end
end


### Given ###
Given /^I have (\d+) molecules$/ do |number|
  n = number.to_i
  create_molecules(n)  
end

Given /^I have a molecule$/ do
    @molecule = FactoryGirl.create(:molecule)
end

Given /^My molecule has (\d+) batches$/ do |number|
 n = number.to_i
 create_batches_for_molecule(@molecule, n)
end

Given /^My molecule has 1 batch$/ do
  create_batch_for_molecule(@molecule)
end

Given /^Each of my molecules has (\d+) batches$/ do |number|
  n = number.to_i
  molecules = Molecule.find(:all)
  molecules.each { |molecule| create_batches_for_molecule(molecule, n) }
end
    
    ### When ###
When /^I visit the molecule list$/ do
    visit molecules_path
end


When /^I visit my molecule's page$/ do
    visit url_for(@molecule)
end


### Then ###
Then /^I should see the names of all the molecules$/ do
    @molecules.each do |molecule|
        page.should have_content molecule.name
    end
end

Then /^I should see the lot_numbers of all the batches$/ do
    @molecule.batches.each do |batch|
        page.should have_content batch.lot_number
    end
end

Then /^I should see the molecule name$/ do
    page.should have_content @molecule.name
end



