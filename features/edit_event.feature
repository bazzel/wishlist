@javascript
Feature: Editing an event

  Scenario: Edit event from index page
    Given I signed in
    And I have created the following events:
      | title          |
      | Awesome Event  |
      | Awesomer Event |
    And I open the application
    And I click "Bewerken" for event "Awesome Event"
    Then I am seeing a page for editing the event

  Scenario: Edit event from show page
    Given I am adding a new event
    And I fill in "Titel" with "Awesome Event"
    And I click "Opslaan"
    When I choose "Bewerken" from the "more_vert" menu
    Then I am seeing a page for editing the event

  Scenario: Add a user
    Given I signed in
    And I have created the following events:
      | title          |
      | Awesome Event  |
    And I open the application
    And I click "Bewerken" for event "Awesome Event"
    When I add "jane@example.org" as guest
    And I click "Opslaan"
    And I navigate to the events page
    Then I see a page with 1 event
    When I signed in with my email address "jane@example.org"
    And I open the application
    Then I see a page with 1 event

  Scenario: Remove a user
    Given I signed in
    And I have created the following events:
      | title         | guest_emails     |
      | Awesome Event | jane@example.org |
    And I open the application
    And I click "Bewerken" for event "Awesome Event"
    When I remove "jane@example.org" as guest
    And I click "Opslaan"
    And I navigate to the events page
    Then I see a page with 1 event
    When I signed in with my email address "jane@example.org"
    And I open the application
    Then I see a page with 0 events

  Scenario: Keep a user
    Given I signed in
    And I have created the following events:
      | title         | guest_emails                        |
      | Awesome Event | marty@example.org, jane@example.org |
    And I open the application
    And I click "Bewerken" for event "Awesome Event"
    When I remove "marty@example.org" as guest
    And I click "Opslaan"
    And I navigate to the events page
    Then I see a page with 1 event
    When I signed in with my email address "jane@example.org"
    And I open the application
    Then I see a page with 1 event
