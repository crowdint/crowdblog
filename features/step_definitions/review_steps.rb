When /^I (un)?mark the Test post for review$/ do |negation|
  within "#post-#{@post.id}" do
    click_button "Review"
  end
end

Then /^the Test post should be marked for review$/ do
  within "#post-#{@post.id}" do
    link = find_button('Review')
    link[:class].should =~ /btn-warning/
  end
  @post.reload
  @post.ready_for_review.should be_true
end

Then /^the Test post should not be marked for review$/ do
  within "#post-#{@post.id}" do
    link = find_button('Review')
    link[:class].should_not =~ /btn-warning/
  end
  @post.reload
  @post.ready_for_review.should be_false
end

Given /^the Test Post is marked for Review$/ do
  @post.update_attribute :ready_for_review, true
end
