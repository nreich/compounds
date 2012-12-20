Feature: View Molecules
    In order to see the molecule availible
    As a user
    I want to view the molecules index

Scenario: Molecules List
    Given I have 5 molecules
    When I visit the molecule list
    Then I should see the names of all the molecules

Scenario: Molecule Page
    Given I have a molecule
        And My molecule has 3 batches
   When I visit my molecule's page
   Then I should see the lot_numbers of all the batches

