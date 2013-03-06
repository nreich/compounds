Feature: View Batches
    In order to see the information availible
    As a user
    I want to view the batch show page and index page

Scenario: Batch Page
    Given I have a molecule
        And My molecule has 1 batch
    When I visit the show page for the batch
    Then I should see its' lot number

Scenario: Batch Index
    Given I have 3 molecules
        And Each of my molecules has 2 batches
    When I visit the batch index page
    Then I should see the information for each batch
