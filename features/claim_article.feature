@javascript
Feature: Claim article

  Scenario: Claim article
    Given I signed in
    And I have created the following events:
      | title         | guest_emails                        |
      | Awesome Event | marty@example.org, jane@example.org |
    And the following articles:
      | title           | event         | guest_email       |
      | Awesome Article | Awesome Event | marty@example.org |
    And I open the article list for "Awesome Event"
    And I hover over the article "Awesome Article"
    When I click the "gavel" button
    Then I should have claimed article "Awesome Article"

  Scenario: Unclaim article
    Given I signed in
    And I have created the following events:
      | title         | guest_emails                        |
      | Awesome Event | marty@example.org, jane@example.org |
    And the following articles:
      | title           | event         | guest_email       |
      | Awesome Article | Awesome Event | marty@example.org |
    And I open the article list for "Awesome Event"
    And I have claimed the article "Awesome Article"
    And I open the article list for "Awesome Event"
    And I hover over the article "Awesome Article"
    When I click the "gavel" button
    Then I should not have claimed article "Awesome Article"

  Scenario: Creator cannot claim his own article
  Scenario: User cannot claim an article already claimed
  Scenario: Creator can still delete claimed article
  Scenario: Article becomes available when claimant is deleted
