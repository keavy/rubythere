Feature: Events in calendar
  In order to plan my time
  As a user
  I want to view upcoming events in my calendar

  Scenario: Viewing the home page
    Given I am a visitor
    When I go to "the home page"
    Then I should see "iCal Download"

  Scenario: Downloading the calendar
    Given I am on "the home page"
    When I follow "Download"
    Then I should have downloaded a file called "RubyThere.ics"