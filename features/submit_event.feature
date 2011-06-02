Feature: Submit event
  In order have my event included on Ruby There
  As a user
  I want to submit an event

  Given the following locations exist:
    | city     | country       |
    | New York | United States |

  Scenario: a visitor can submit an event, with an existing location
    Given I am a visitor
    And I am on the new event page
    When I fill in "Name" with "My conf"
    And I fill in "Twitter name" with "myconf"
    And I fill in "URL" with "http://www.myconf.com"

    And I select "United States" from existing locations

    And I fill in "First name" with "Joe"
    And I fill in "Last name" with "Smith"
    And I fill in "Email" with "name@example.com"

    And I press "submit"
    Then I should see "Thanks! Your event has been submitted for review"
  
  Scenario: a visitor can submit an event, with a new existing location
    Given I am a visitor
    And I am on the new event page
    When I fill in "Name" with "My conf"
    And I fill in "Twitter name" with "myconf"
    And I fill in "URL" with "http://www.myconf.com"

    And I fill in "City" with "Glasgow"
    And I select "United Kingdom" from countries

    And I fill in "First name" with "Joe"
    And I fill in "Last name" with "Smith"
    And I fill in "Email" with "name@example.com"

    And I press "submit"
    And show me the page
    # Then I should see "Thanks! Your event has been submitted for review"