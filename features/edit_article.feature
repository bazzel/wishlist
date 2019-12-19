@javascript
Feature: Edit an article

  @wip
  Scenario: Edit an article
    Given I signed in
    And I have created the following articles:
      | title         | event     |
      | Awesome Article | Awesome Event |
    And I open the article list for "Awesome Event"
    And I hover over the article "Awesome Article"
    And I click the "create" button
    And I fill in "Prijs" with "25"
    And I click "Opslaan"
    And I am having 1 article

