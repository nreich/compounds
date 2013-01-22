Feature: Show User
  In order to learn more about a user
  As a user
  I want to to be able to view a user's page

  Scenario: 
    Given a user exists
    When I visit their show page
    Then I should see their name
    And I should see their email address
