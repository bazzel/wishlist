@javascript
Feature: Edit an article

  Scenario: Opening a modal for editing an article
    Given I signed in
    And I have created the following articles:
      | title           | event         |
      | Awesome Article | Awesome Event |
    And I open the article list for "Awesome Event"
    And I hover over the article "Awesome Article"
    When I click the "create" button
    Then I see a modal with "Awesome Article" as title
    When I fill in "Prijs" with "25"
    And I click "Opslaan"
    Then I should see 1 article
