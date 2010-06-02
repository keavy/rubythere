Feature: Manage events
  In order to keep my event details up to date 
  As a user  
  I want to edit the event(s) I am authorized for 
  
  Scenario: Viewing my event page  
    Given I am signed in  
    And I have an event called "myconf"
    And twitter has some search results for "myconf"
    When I go to the event page for myconf
    And I should see "Update event details"
    
  Scenario: Viewing another's event page  
    Given I am signed in  
    And there is an event called "another conf"
    And twitter has some search results for "another conf"
    When I go to the event page for another conf
    And I should not see "Update event details"
    
  Scenario: Viewing an event page as a visitor
    Given I am a visitor
    And there is an event called "myconf"
    And twitter has some search results for "myconf"
    When I go to the event page for myconf
    And I should see "Event organisers login"