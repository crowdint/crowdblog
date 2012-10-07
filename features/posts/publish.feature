@javascript
Feature: Posts Publication
  As a Publisher
  I want to be able to publish drafted Posts

  Background:
    Given the Test Post exists
      And the Published Post exists
      And I am signed in as Publisher User
      And I go to the posts page

  Scenario: Publish a Post
    When I Publish a drafted Post
    Then I should see the Post as Published

  Scenario: Un-Publish a Post
    When I Draft a published Post
    Then I should see the Post as Drafted
