@javascript
Feature: Posts Listing
  As a User
  I should only see my own posts

  Scenario: Show only User Posts
    Given I am signed in as "test@test.com"
      And An author with name "Johan Crupps" and email "johan@crupps.com"
      And the following posts by "Johan Crupps":
          | title               | body                            | published |
          | The great gatsby    | Lorem Ipsum Cohiben Allen       | false     |
    When I go to the posts page
    Then I should not see "The great gatsby"
