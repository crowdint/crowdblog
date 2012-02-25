Given /^I click on "([^"]*)"$/ do |link_name|
  click_link link_name
end

Given /^I press "([^"]*)"$/ do |button_name|
  click_button button_name
end

Then /^I should see "([^"]*)"$/ do |expectation|
  page.should have_content expectation
end

When /^I click "([^"]*)" for "([^"]*)"$/ do |link_text, row_text|
  page.execute_script 'window.confirm = function() { return true }'
  find("tr:contains('#{row_text}')").find("a:contains('#{link_text}')").click
end

Then /^I should not see "([^"]*)"$/ do |expectation|
  page.should_not have_content expectation
end

Then /^I should see:$/ do |table|
  table.raw.flatten.each do |expected|
    page.should have_content expected
  end
end

#OLD Post steps
Then /^the post titled "([^"]*)" is marked as published$/ do |post_title|
  @current_post = Crowdblog::Post.find_by_title(post_title)
  @current_post.should be_published
end

Then /^current user is set as its publisher$/ do
  @current_post.publisher.should == @current_user
end

Then /^the post titled "([^"]*)" is marked as drafted$/ do |post_title|
  @current_post = Crowdblog::Post.find_by_title(post_title)
  @current_post.should be_drafted
end
