shared_examples_for "a crowdblog" do
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
      visit crowdblog.new_user_session_path
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
    end

    it "creates a post" do
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
  end
end
