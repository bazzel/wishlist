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
    When I click the thumbtack button
    Then I should have claimed article "Awesome Article"
    But I should not see that article "Awesome Article" is claimed

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
    When I click the thumbtack button
    Then I should not have claimed article "Awesome Article"

  Scenario: Creator cannot claim his own article
    Given I signed in
    And I have created the following events:
      | title         |
      | Awesome Event |
    And I have created the following article:
      | title           | event         |
      | Awesome Article | Awesome Event |
    When I open the article list for "Awesome Event"
    Then I should not be able to claim the article "Awesome Article"
    But I should not see that article "Awesome Article" is claimed

  Scenario: User cannot claim an article already claimed
    Given I signed in
    And I have created the following events:
      | title         | guest_emails                        |
      | Awesome Event | marty@example.org, jane@example.org |
    And the following articles:
      | title           | event         | guest_email       | claimant_email   |
      | Awesome Article | Awesome Event | marty@example.org | jane@example.org |
    And I open the article list for "Awesome Event"
    Then I should not be able to claim the article "Awesome Article"
    And I should see that article "Awesome Article" is claimed

  Scenario: Creator can still delete claimed article
    Given I signed in
    And I have created the following events:
      | title         | guest_emails      |
      | Awesome Event | marty@example.org |
    And I have created the following article:
      | title           | event         | claimant_email    |
      | Awesome Article | Awesome Event | marty@example.org |
    And I open the article list for "Awesome Event"
    And I hover over the article "Awesome Article"
    When I click the "delete" button
    Then I should see 0 articles

  Scenario: Article becomes available when claimant is deleted
    Given I signed in
    And I have created the following events:
      | title         | guest_emails                        |
      | Awesome Event | marty@example.org, jane@example.org |
    And the following articles:
      | title           | event         | guest_email       | claimant_email   |
      | Awesome Article | Awesome Event | marty@example.org | jane@example.org |
    And I open the application
    And I click "Bewerken" for event "Awesome Event"
    When I remove "jane@example.org" as guest
    And I click "Opslaan"
    When I open the article list for "Awesome Event"
    Then I should be able to claim the article "Awesome Article"
