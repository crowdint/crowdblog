@javascript
Feature: Posts Publication
  As a Publisher
  I want to be able to publish drafted Posts

Scenario: Publish a drafted Post
  Given I am signed in as "test@test.com"
    And current user is publisher
    And An author with name "Johan Crupps" and email "johan@crupps.com"
    And the following posts by "Johan Crupps":
        | title               | body                            | published |
        | The great gatsby    | Lorem Ipsum Cohiben Allen       | false     |
  When I go to the posts page
    And I click on "Publish"
  Then the post titled "The great gatsby" is marked as published
    And current user is set as its publisher
  When I click on "Publish"
  Then the post titled "The great gatsby" is marked as drafted
