Feature:
  As a user
  I can log in
  so I can do authorized tasks

  @wip
  Scenario: Show the sign in page
    When I open the application
    Then I see the sign in page

  @todo
  Scenario: Redirect to the sign in page
    When I navigate to the welcome page
    Then I'm being redirected to the sign in page

  @todo
  Scenario: Sign in with a valid email address
    Given I am on the Sign in page
    And I fill in "Email" with "john.doe@example.org"
    And I click "Sign in"
    Then "john.doe@example.org" should receive an email
    And I see a page with instructions for "john.doe@example.org" how to login

  @todo
  Scenario: Sign in with valid url
    Given I sign up with my email address "john.doe@example.org"
    When I use the magic link
    Then I'm in

  @todo
  Scenario: Sign out
    Given I signed in with my email address "john.doe@example.org"
    When I sign out
    Then I'm out

  @todo
  Scenario: Sign up without email address
    Given I am on the Sign in page
    And I click "Sign in"
    Then I see an error telling me an email address is required

  @todo
  Scenario: Sign up with an invalid email address
    Given I am on the Sign in page
    And I fill in "Email" with "john.doe"
    And I click "Sign in"
    Then I see an error telling me I have entered an invalid email address

