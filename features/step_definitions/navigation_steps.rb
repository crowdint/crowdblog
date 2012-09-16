#*****************
#   GIVEN steps
#-----------------
Given /^(?:|I )(?:go to|am on) the posts page$/ do
  visit posts_path
end

Given /^(?:|I )am on the Edit Post page$/ do
  @post.should_not be_nil
  visit posts_path + "#edit/#{@post.id}"
end

Given /^(?:|I )am on the New Post page$/ do
  visit posts_path + '#new'
end


#*****************
#   WHEN steps
#-----------------
When /^(?:|I )confirm the popup dialog$/ do
  if Capybara.javascript_driver == :selenium
    page.driver.browser.switch_to.alert.accept
  else
    page.execute_script 'window.confirm = function() { return true }'
  end
end

When /^(?:|I )navigate to Edit Post$/ do
  post = page.find('#posts table tr', text: 'This is a Test Post')

  post.click_button 'Edit'
end

When /^(?:|I )navigate to New Post$/ do
  click_link 'New Post'
end


#*****************
#   THEN steps
#-----------------
#Then /^show me the page$/ do
#  save_and_open_page
#end
