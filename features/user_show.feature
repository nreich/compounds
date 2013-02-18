Feature: Show User
  In order to learn more about a user
  As a user
  I want to to be able to view a user's page

  Scenario: 
    Given a user exists
    When I visit that user's show page
    Then I should see their name
    And I should see their email address

  Scenario:
    Given a user exists
    And the user has 3 transactions
    When I visit that user's show page
    Then I should see a table of their transactions
