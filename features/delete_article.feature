@javascript
Feature: Delete an article

  @wip
  Scenario: Delete an article
    Given I signed in
    And I have created the following articles:
      | title           | event         |
      | Lorem Article | Awesome Event |
      | Ipsum Article | Awesome Event |
      | Dolor Article | Awesome Event |
    And I open the article list for "Awesome Event"
    And I hover over the article "Lorem Article"
    When I click the "delete" button
    Then I should see 2 articles

  Scenario: Undo deleting an article
    Given I signed in
    And I have created the following articles:
      | title           | event         |
      | Lorem Article | Awesome Event |
      | Ipsum Article | Awesome Event |
      | Dolor Article | Awesome Event |
    And I open the article list for "Awesome Event"
    And I hover over the article "Lorem Article"
    When I click the "delete" button
    And I undo deleting the article
    Then I should see 3 articles
