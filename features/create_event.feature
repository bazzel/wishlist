Feature: Creating an event

  Scenario: Add first event
    Given I signed in
    When I click the "add" button
    Then I am seeing a page for adding a new event
    But I am not seeing the button for adding a new event

  Scenario: Create an event
    Given I am adding a new event
    When I fill in "Titel" with "Awesome Event"
    And I click "Opslaan"
    Then I am viewing the event
    And I can edit the event
    And I am seeing the button for adding a new event

  @wip
  Scenario: Event is not visible to others
    Given I signed in
    And I have created the following events:
      | title |
      | Awesome Event |
      | Awesomer Event |
    When I open the application
    Then I see a page with 2 events
    When I signed in with my email address "jane@example.org"
    And I open the application
    Then I see a page with 0 events

  @todo
  Scenario: Invite guests
