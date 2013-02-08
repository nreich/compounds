Feature: Show Transaction
  in order to find out more about a specific transaction
  As a user
  I want to be able to view a transaction's page

  Scenario:
    Given I have a molecule
    And My molecule has 1 batch
    And My batch has a transaction
    When I visit the transaction's show page
    Then I should see the transaction amount
    And I should see the transaction's batch number
    And I should see the transaction's molecule name
    And I should see the name of the user that made the transaction
    And I should see when the transaction occured
