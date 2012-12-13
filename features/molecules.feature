Feature: View Molecules
    In order to see the molecule availible
    As a user
    I want to view the molecules index

Scenario: Molecules List
    Given I have molecules named First, Second
    When I go to the list of molecules
    Then I should see "First"
    And I should see "Second"

Scenario: Molecule Page
    Given I have a molecule named First
        And My molecule has batches 100, 200
    When I visit my molecule's page
    Then I should see "First"
        And I should see "100"
        And I should see "200"


