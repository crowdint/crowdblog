#*****************
#   GIVEN steps
#-----------------
Given /^(a|\d+) Post.? from other User exists$/ do |number|
  number = 1 if number.to_i < 1

  number.times { Fabricate :post, author: Fabricate(:user) }
end

Given /^(?:|the )Published Post exists$/ do
  step 'Publisher User exists' unless @current_user
  step 'Test User exists' unless @current_user

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

Then /^(?:|I )should only see my Posts$/ do
  posts = page.find('#posts table')

  posts.should have_content 'This is a Test Post'
  posts.should_not have_content 'Random Post title'
end

Then /^(?:|I )should see my New Post$/ do
  posts = page.find('#posts table')

  posts.should have_content 'A Great Post Title'  # Post Title
  posts.should have_content 'test@crowdint.com'   # Post Author

  post = Crowdblog::Post.find_by_title('A Great Post Title')
  post.reload.author.should == @current_user
  post.permalink.should == 'a-great-post-title'
end

Then /^(?:|I )should see Posts for all Users$/ do
  posts = page.find('#posts table')

  posts.should have_content 'This is a Test Post'
  posts.should have_content 'Random Post title'
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
