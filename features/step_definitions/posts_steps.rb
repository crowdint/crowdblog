#*****************
#   GIVEN steps
#-----------------
Given /^(?:|I )am on the Edit Post page$/ do
  @post.should_not be_nil
  visit posts_path + "#edit/#{@post.id}"
end

Given /^(?:|I )am on the New Post page$/ do
  visit posts_path + '#new'
end

Given /^(?:|the )Published Post exists$/ do
  step 'Test User exists' unless @current_user
  step 'Publisher User exists' unless @current_user

  @published_post = Fabricate :post_published, author: @current_user, publisher: @publisher_user
end

Given /^(?:|the )Test Post exists$/ do
  step 'Test User exists' unless @current_user

  @post = Fabricate :post_test, author: @current_user
end


#*****************
#   WHEN steps
#-----------------
When /^(?:|I )delete the Test Post$/ do
  post = page.find('#posts table tr', text: 'This is a Test Post')

  post.click_link 'Delete'
  step 'confirm the popup dialog'
end

When /^(?:|I )Draft a published Post$/ do
  post = page.find('#posts table tr', text: 'This is a Published Post')

  post.click_link 'Publish' # button should be 'Draft' ?
end

When /^(?:|I )edit the Test Post$/ do
  fill_in 'Title', with: 'I just edited this Post'
  fill_in 'Body',  with: 'OMG, I changed the body of this post!'
  click_button 'Save'
end

When /^(?:|I )navigate to Edit Post$/ do
  post = page.find('#posts table tr', text: 'This is a Test Post')

  post.click_link 'Edit'
end

When /^(?:|I )navigate to New Post$/ do
  click_link 'New Post'
end

When /^(?:|I )Publish a drafted Post$/ do
  post = page.find('#posts table tr', text: 'This is a Test Post')

  post.click_link 'Publish'
end

When /^(?:|I )write a Post$/ do
  fill_in 'Title', with: 'A Great Post Title'
  fill_in 'Body',  with: 'I just wrote a loooooooong Post'
  click_button 'Save'
end


#*****************
#   THEN steps
#-----------------
Then /^(?:|I )should not see the Test Post$/ do
  posts = page.find('#posts table')

  posts.should_not have_content 'This is a Test Post'
end

Then /^(?:|I )should see my New Post$/ do
  posts = page.find('#posts table')

  posts.should have_content 'A Great Post Title'  # Post Title
  posts.should have_content 'test@crowdint.com'   # Post Author

  step 'the post "A Great Post Title" should be authored by current user'
  step 'the post "A Great Post Title" should have "a-great-post-title" as its permalink'
end

Then /^(?:|I )should see the Edit Post page$/ do
  page.should have_content 'Edit Post'

  step 'should see the Post form'
end

Then /^(?:|I )should see the New Post page$/ do
  page.should have_content 'New Post'

  step 'should see the Post form'
end

Then /^(?:|I )should see the Post as Drafted$/ do
  @post.reload.should be_drafted
end

Then /^(?:|I )should see the Post as Published$/ do
  @post.reload.should be_published          # Post is published
  @post.publisher.should == @current_user   # Post published by Publisher
end

Then /^(?:|I )should see the Post form$/ do
  form = page.find('.container form')

  form.should have_content 'Title'
  form.should have_content 'Body'
  form.should have_content 'Markdown syntax'
  form.should have_content 'Save'
  form.should have_content 'Cancel'
end

Then /^(?:|I )should see the Test Post changed$/ do
  posts = page.find('#posts table')

  posts.should have_content 'I just edited this Post'
end

Then /^(?:|the )post "([^"]*)" should be authored by current user$/ do |post_title|
  post = Crowdblog::Post.find_by_title(post_title)
  post.author.should == @current_user
end

Then /^(?:|the )post "([^"]*)" should have "([^"]*)" as its permalink$/ do |post_title, permalink|
  post =Crowdblog::Post.find_by_title(post_title)
  post.permalink.should == permalink
end
