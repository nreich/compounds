Feature: Sign up
  In order to access protected sections of the site
  As a user
  I want to sign up

    Scenario: I sign up successfully
      When I sign up with valid user data
      Then I should successfully become a user
      And I should be redirected to the homepage
      And I should see a successful sign up message

    Scenario: I sign up unsuccessfully
      When I sign up with invalid data
      Then I should not become a user
      And I should still be on the sign up page
      And I should see a message about why I failed to sign up
