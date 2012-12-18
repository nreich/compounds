Feature: View Batches
    In order to see the information availible
    As a user
    I want to view the batch show page and index page

Scenario: Batch Page
    Given I have a molecule named First
        And My molecule has batches 100
    When I visit the show page for the batch
    Then I should see "100"

Scenario: Batch Index
    Given I have a molecule named First
        And My molecule has batches 100, 200
    When I visit the batch index page
    Then I should see "100"
        And I should see "200"
