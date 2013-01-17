shared_examples_for "a crowdblog", :type => :feature do

  let(:post) do
    Crowdblog::Post.create :title => 'A post title', :body => 'A post body'
  end

  describe "Home" do
    it "shows published posts" do
      post.save!
      post.publish

      visit crowdblog.root_path

      within "#post_#{post.id}" do
        page.should have_content post.title
        page.should have_content post.body
      end
    end
  end

  describe "Admin" do
    describe "manage posts" do
      it "creates a post", :js => true do
        visit crowdblog.admin_posts_path
        click_link 'New Post'

        fill_in 'Title', :with => 'A post title'
        fill_in 'Body' , :with => 'A post body'
        click_button 'Update'

        page.current_path.should == crowdblog.admin_posts_path
        page.should have_content 'A post title'
      end

      context "a post exists" do
        before do
          post
          post.save!
        end

        it "edits a post" do
          visit crowdblog.admin_posts_path
          within "#post_#{post.id}" do
            click_link 'Edit'
          end

          fill_in 'Title', :with => 'A NEW post title'
          fill_in 'Body' , :with => 'A NEW post body'
          click_button 'Update'

          page.current_path.should == crowdblog.admin_posts_path
          page.should have_content 'A NEW post title'
        end

        it "deletes a post" do
          visit crowdblog.admin_posts_path

          within "#post_#{post.id}" do
            click_link 'Delete'
          end
          page.current_path.should == crowdblog.admin_posts_path
          page.should_not have_content 'A post title'
        end

        it "publishes a post", :js => true do
          visit crowdblog.admin_posts_path

          within "#post_#{post.id}" do
            button = find_link 'Publish'
            button.click

            page.should have_css 'a.btn-success'
            post.reload.state.should eq 'published'
          end
        end

        it "draftes a post", :js => true do
          post.publish!

          visit crowdblog.admin_posts_path

          within "#post_#{post.id}" do
            button = find_link 'Publish'
            button.click

            page.should have_css 'a.btn-danger'
            post.reload.state.should eq 'drafted'
          end
        end

        it "marks the post for review", :js => true do
          visit crowdblog.admin_posts_path

          within "#post_#{post.id}" do
            button = find_link 'Review'
            button.click

            page.should have_css 'a.btn-warning'
            post.reload.ready_for_review.should be_true
          end
        end
      end
    end
  end
end
