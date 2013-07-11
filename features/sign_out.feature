Feature: Sign out
  To protect my account from unauthorized access
  As currently signed in user
  I should be able to sign out

    Scenario: I sign out of the website
      Given: I am logged in
      When I sign out
      Then I should be redirected to the sign in page
      When I return to the site
      Then I should be signed out
