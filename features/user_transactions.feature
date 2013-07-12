Feature: Transactions of a Batch
  In order to see who is using a compound
  As a user
  I want to see a table of a user's transactions

  Background:
    Given I am logged in
    Given there is another user

  Scenario: The user has at least one transction
    Given another user has any transactions
    When I go to their user page
    Then I see a table with their transactions

  Scenario: The user has not made any transactions
    Given another user has no transactions
    When I go to their user page
    Then I do not see a table for transactions
    And I see a note that they have not made any transactions
