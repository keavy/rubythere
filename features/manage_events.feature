Feature: Manage events
  In order to keep my event details up to date 
  As a user  
  I want to edit the event(s) I am authorized for 
  
  Scenario: Viewing my event page  
    Given I am signed in  
    And I have an event called "myconf"
    When I view the event page for myconf
    Then I should see "Update event details"
    
  Scenario: Viewing another's event page  
    Given I am signed in  
    And there is an event called "another conf"
    When I view the event page for another conf
    Then I should not see "Update event details"
    
  Scenario: Viewing an event page as a visitor
    Given I am a visitor
    And there is an event called "myconf"
    When I view the event page for myconf
    Then I should see "Event organisers login"