Feature: Submit event
  In order have my event included on Ruby There
  As a user
  I want to submit an event

  Scenario: a visitor can submit an event
    Given I am a visitor
    And I am on the new event page
    When I fill in "event_name" with "My conf"
    And I fill in "event_twitter" with "myconf"
    And I fill in "event_happenings_attributes_0_url" with "http://www.myconf.com"
    And I fill in "event_submitter_attributes_last_name" with "Smith"
    And I fill in "event_submitter_attributes_first_name" with "Joe"
    And I fill in "event_submitter_attributes_email" with "name@example.com"
    And I press "submit"
    Then I should see "Thanks! Your event has been submitted for review"