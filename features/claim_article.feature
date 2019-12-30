@javascript
Feature: Claim article

  @wip
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
  Scenario: Creator cannot claim his own article
  Scenario: User cannot claim an article already claimed
  Scenario: Creator can still delete claimed article
  Scenario: Article becomes available when claimant is deleted
