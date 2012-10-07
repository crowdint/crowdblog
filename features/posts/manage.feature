Feature: Manage Posts
  As a User
  I want to be able to manage Posts (CRUD)

  Background:
    Given the Test User exists
      And the Test Post exists
      And I am signed in as Test User
      And I go to the posts page

  Scenario: Edit Post
    Given I am on the Edit Post page
    When I edit the Test Post
    Then I should see the Test Post changed

  Scenario: Delete Posts
    When I delete the Test Post
    Then I should not see the Test Post

  Scenario: Navigate to New Post
    When I navigate to New Post
    Then I should see the Edit Post page

  Scenario: Navigate to Edit Post
    When I navigate to Edit Post
    Then I should see the Edit Post page

  @javascript
  Scenario: Post Preview
    Given I am on the New Post page
    When I type in the post body field
    Then I should see its markdown preview
