Feature: Admin abilities
  As an admin
  In order to maintain the site's information
  I want to be able to edit and destroy resources

  Background:
    Given I am a logged in admin

  Scenario: I delete a batch
    Given the batch I want exists
    When I go to the page for a batch
    And I click the link to destroy the batch
    Then the batch no longer exists

  Scenario: I edit a batch
    Given the batch I want exists
    When I go to the page for a batch
    And I click the link to edit the batch
    And I edit its barcode
    Then the batch's barcode gets changed
