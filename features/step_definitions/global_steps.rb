Given /^(?:|I )am signed in as (Test|Publisher) User$/ do |user_type|
  step "#{user_type} User exists"

  visit new_user_session_path

  if user_type == 'Test'
    fill_in 'Email', :with => 'test@crowdint.com'
  else
    fill_in 'Email', :with => 'publisher@crowdint.com'
  end
  fill_in 'Password', :with => '123456'
  click_button 'Sign in'
end

Given /^(?:|the )Test User exists$/ do
  @current_user = Crowdblog::User.find_by_email('test@crowdint.com')

  unless @current_user
    @current_user = Crowdblog::User.new
    @current_user.email = 'test@crowdint.com'
    @current_user.password = '123456'
    @current_user.password_confirmation = '123456'
    @current_user.save!
  end
end

Given /^(?:|the )Publisher User exists$/ do
  @current_user = Crowdblog::User.find_by_email('publisher@crowdint.com')

  unless @current_user
    @current_user = Crowdblog::User.new
    @current_user.email = 'publisher@crowdint.com'
    @current_user.password = '123456'
    @current_user.password_confirmation = '123456'
    @current_user.is_publisher = true
    @current_user.save!
  end

  @publisher_user = @current_user
end

Then /^show me the page$/ do
  save_and_open_page
end
