Feature: Authentication
  In order be authorized
  As a user
  I want to log in with Twitter

  Scenario: Viewing the home page
    Given I am signed in
    When I go to "the home page"
    Then I should see "logged in as"
    And I should see "logout"