Feature: Transactions of a Batch
  In order to find out about usage of a batch
  As a user
  I want to see a table of the batch's transactions

  Background:
    Given I am logged in

  Scenario: The batch has at least one transaction
    Given there are any transactions for a batch
    When I go to the page for a batch
    Then I see a table with its transactions

  Scenario: The batch has no transactions
    Given there are no transactions for a batch
    When I go to the page for a batch
    Then I do not see a table of transactions
    And I see a note that this batch has no transactions
