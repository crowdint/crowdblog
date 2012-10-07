shared_examples_for "a crowdblog", :type => :integration do

  let(:user) do
    user = Crowdblog::User.new :email => 'test@example.com'
    user.password = '123456'
    user.password_confirmation = '123456'
    user.save!
    user
  end

  let(:post) do
    Crowdblog::Post.create :title => 'A post title', :body => 'A post body'
  end

  describe "manage posts" do
    before do
      Crowdblog::PostsController.any_instance.stub(:authenticate_user!)
      Crowdblog::PostsController.any_instance.stub(:current_user).and_return user
    end

    it "creates a post", :js => true do
      visit crowdblog.posts_path
      click_link 'New Post'

      fill_in 'Title', :with => 'A post title'
      fill_in 'Body', :with => 'A post body'
      click_button 'Update'

      page.current_path.should == crowdblog.posts_path
      page.should have_content 'A post title'
    end

    it "edits a post" do
      post
      post.author = user
      post.save!

      visit crowdblog.posts_path
      within "#post_#{post.id}" do
        click_link 'Edit'
      end

      fill_in 'Title', :with => 'A NEW post title'
      fill_in 'Body', :with => 'A NEW post body'
      click_button 'Update'

      page.current_path.should == crowdblog.posts_path
      page.should have_content 'A NEW post title'
    end

    it "deletes a post" do
      post
      post.author = user
      post.save!

      visit crowdblog.posts_path

      within "#post_#{post.id}" do
        click_link 'Delete'
      end
      page.current_path.should == crowdblog.posts_path
      page.should_not have_content 'A post title'
    end

    it "publishes a post", :js => true do
      user.publisher!

      post
      post.author = user
      post.save!

      visit crowdblog.posts_path

      within "#post_#{post.id}" do
        button = find_link 'Publish'
        button.click

        button[:class].should match /btn-success/
        post.reload.state.should eq 'published'

        button.click
        button[:class].should match /btn-danger/
        post.reload.state.should eq 'drafted'
      end
    end

    it "marks the post for review", :js => true do
      user.publisher!

      post
      post.author = user
      post.save!

      visit crowdblog.posts_path

      within "#post_#{post.id}" do
        button = find_link 'Review'
        button.click

        button[:class].should match /btn-warning/
        post.reload.ready_for_review.should be_true

        button.click
        button[:class].should_not match /btn-warning/
        post.reload.ready_for_review.should be_false
      end
    end
  end
end
