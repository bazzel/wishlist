Feature:
  As a user
  I can log in
  so I can do authorized tasks

  Scenario: Show the sign in page
    When I open the application
    Then I see the sign in page

  Scenario: Redirect to the sign in page
    When I navigate to the events page
    Then I'm being redirected to the sign in page

  Scenario: Sign in with a valid email address
    Given I am on the Sign in page
    When I sign up with my email address "john.doe@example.org"
    Then "john.doe@example.org" should receive an email
    And I see a page with instructions for "john.doe@example.org" how to login

  Scenario: Sign in with valid url
    Given I am on the Sign in page
    And I sign up with my email address "john.doe@example.org"
    When I use the magic link
    Then I'm in

  Scenario: Sign out
    Given I signed in with my email address "john.doe@example.org"
    When I sign out
    Then I'm out

  Scenario: Sign up without email address
    Given I am on the Sign in page
    When I sign up without an email address
    Then I see an error telling me an email address is required

  Scenario: Sign up with an invalid email address
    Given I am on the Sign in page
    And I sign up with my email address "john.doe"
    Then I see an error telling me I have entered an invalid email address
