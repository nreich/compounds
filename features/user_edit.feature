Feature: Edit User
  As a registered user of the website
  I want to edit my user profile
  So I can change my personal information

  Background:
    Given I am logged in

  Scenario: I edit my account details
    When I edit my account details
    Then I should see an account edited message
    And my account details should have changed

  Scenario: I edit my account details with invalid information
    When I edit my account but enter invalid information
    Then I should see a message about what I entered wrong
    And I should still see the account editing form
    And my account details should not have changed
