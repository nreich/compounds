Feature: Vist Home Page
  In order to navigate the site
  As a user
  I want to visit key pages on the website from the home page

  Background:
    Given I am logged in

  Scenario: User visits home page from root address
    When I visit root
    Then I should be on the home page

  Scenario: User visits home page
    When I visit the home page
    Then I should see a link to the molecules page
    And I should see a link to the batches page
    And I should see a link to the transactions page
