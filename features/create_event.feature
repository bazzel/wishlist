Feature: Creating an event

  Scenario: Add first event
    Given I signed in
    When I click the "add" button
    Then I am seeing a page for adding a new event
    But I am not seeing the button for adding a new event

  @wip
  Scenario: Create an event
    Given I am adding a new event
    When I fill in "Titel" with "Awesome Event"
    And I click "Opslaan"
    Then I am viewing the event
    And I can edit the event
    And I am seeing the button for adding a new event

  @todo
  Scenario: Event is not visible to others
  @todo
  Scenario: Invite guests
