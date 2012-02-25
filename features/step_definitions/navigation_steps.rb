Given /^(?:|I )(?:go to|am on) the posts page$/ do
  visit posts_path
end

When /^(?:|I )confirm the popup dialog$/ do
  if Capybara.javascript_driver == :selenium
    page.driver.browser.switch_to.alert.accept
  else
    page.execute_script 'window.confirm = function() { return true }'
  end
end
