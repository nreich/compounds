Feature: Sign in
  In order to access protected sections of this site
  As an existing user
  I want to to sign in

  Background:
    Given I am not logged in

    Scenario: I visit the website before signing in
      When I visit the homepage
      Then I should be redirected to the sign in page

    Scenario: I try to visit restricted portions of the site before signing in
      When I try to visit pages that are restricted
      Then I should be redirected to the sign in page

    Scenario: I log in with valid credentials
      Given I am already a user
      When I sign in with valid credentials
      Then I see a successful sign in message
      And I am redirected to the homepage
      When I return to the site
      Then I should be signed in

    Scenario: I try to log in with invalid credentials
      When I try to sign in with an invalid email and password
      Then I should see an invalid login message
      And I should still be on the sign in page

