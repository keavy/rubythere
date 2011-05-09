Feature: Submit event
  In order have my event included on Ruby There
  As a user
  I want to submit an event

  Scenario: a visitor can submit an event
    Given I am a visitor
    And I am on the new event page
    When I fill in "Name" with "My conf"
    And I fill in "Twitter name" with "myconf"
    And I fill in "URL" with "http://www.myconf.com"
    And I fill in "First name" with "Joe"
    And I fill in "Last name" with "Smith"
    And I fill in "Email" with "name@example.com"
    And I press "submit"
    Then I should see "Thanks! Your event has been submitted for review"