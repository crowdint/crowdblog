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
