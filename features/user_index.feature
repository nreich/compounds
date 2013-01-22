Feature: User Index
  In order to see all the users of the service
  As a user
  I want to be able to view the user index page

  Scenario:
    Given there are 3 users
    When I visit the user index page
    Then I should see the name of each user
