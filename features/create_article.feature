@javascript
Feature: Creating an article

  Scenario: Viewing the guests
    Given I signed in
    And I have created the following events:
      | title          | guest_emails                        |
      | Awesome Event  | jane@example.org                    |
      | Awesomer Event | marty@example.org, jane@example.org |
    And I open the application
    When I click "Openen" for event "Awesome Event"
    Then I am seeing a page with 3 guests

  @wip
  Scenario: Add first article
  Scenario: Create an article
