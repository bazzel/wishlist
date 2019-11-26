Feature: Editing an event

  @todo
  Scenario: Edit event from index page

  Scenario: Edit event from show page
    Given I am adding a new event
    And I fill in "Titel" with "Awesome Event"
    And I click "Opslaan"
    When I choose "Bewerken" from the "more_vert" menu
    Then I am seeing a page for editing the event

  @todo
  Scenario: Add a user

  @todo
  Scenario: Remove a user

  @todo
  Scenario: Keep a user
