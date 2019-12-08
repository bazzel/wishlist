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

  Scenario: Add first article
    Given I signed in
    And I have created the following events:
      | title         | guest_emails     |
      | Awesome Event | jane@example.org |
    And I open the article list for "Awesome Event"
    When I click the "add" button
    And I click the "add_shopping_cart" button
    Then I am seeing a modal for adding a new article

  Scenario: Create an article
    Given I signed in
    And I have created the following events:
      | title         | guest_emails     |
      | Awesome Event | jane@example.org |
    And I am adding a new article for "Awesome Event"
    When I fill in "Titel" with "Awesome Article"
    And I fill in "Prijs" with "25"
    And I fill in "Omschrijving" with "A very awesome article. At least, that's what I think..."
    And I add the stores "Hema, Blokker"
    And I click "Opslaan"
    Then I am seeing a page with 3 guests
    And I am having 1 article
