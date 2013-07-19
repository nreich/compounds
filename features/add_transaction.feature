Feature: Adding a transaction to a batch
  As a user who has used some of a compound
  In order to record my use of a compound
  I want to create a new transaction to record my use

  Background:
    Given I am logged in
    Given the batch I want exists

  Scenario: I create a new transaction
    When I go to the page for a batch
    And I click the add transaction link
    And I enter a valid amount
    Then I am redirected to the page of the batch
    And my transaction is created
    And the amount remaining in the batch is updated

  Scenario: I try to take out too much compound
    When I go to the page for a batch
    And I click the add transaction link
    And I enter an amount larger than that in the batch
    Then I remain on the new transaction page
    And my transaction is not created
    
