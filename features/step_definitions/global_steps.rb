Given /^(?:|I )am signed in as Test User$/ do
  step 'Test User exists'

  @current_user.authentication_token.should be_present
  visit crowdblog_path + "?auth_token=#{@current_user.authentication_token}"
end

Given /^(?:|the )Test User exists$/ do
  @current_user = Crowdblog::User.find_by_email('test@crowdint.com')

  @current_user = Fabricate(:user_test) unless @current_user
end
