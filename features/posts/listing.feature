@javascript
Feature: Posts Listing
  As a User
  I should only see my own posts

  Background:
    Given the Test Post exists
      And a Post from other User exists

  Scenario: Show only User Posts
    When I am signed in as Test User
    Then I should only see my Posts

  Scenario: Publishers can see all Posts
    When I am signed in as Publisher User
    Then I should see Posts for all Users

  Scenario: Mark a post for review
    Given I am signed in as Test User
    When I mark the Test post for review
    Then the Test post should be marked for review

  Scenario: A post marked for review
    Given the Test Post is marked for Review
    When I am signed in as Test User
    Then the Test post should be marked for review

  Scenario: Unmark a post marked for review
    Given the Test Post is marked for Review
    When I am signed in as Test User
    When I unmark the Test post for review
    Then the Test post should not be marked for review
