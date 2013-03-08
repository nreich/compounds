Feature: Show Batch
  In order to learn more about a batch
  As a user
  I want to be able to view the information on a batch

  Background:
    Given I have a molecule
      And My molecule has 1 batch

  Scenario:
    When I visit the show page for the batch
    Then I should see the information for the batch

