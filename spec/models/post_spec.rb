require 'spec_helper'

module Crowdblog
  describe Post do
    describe 'Class Methods' do
      describe '#self.all_posts_json' do
        it 'convert ordered posts to JSON' do
          Post.should_receive(:order_by_publish_date).and_return Post
          Post.should_receive(:to_json)
          Post.all_posts_json
        end
      end

      describe '#self.last_published' do
        it 'should find the last given post published, ordered' do
          Post.should_receive(:published_and_ordered).and_return Post
          Post.should_receive(:limit).with(11)
          Post.last_published(11)
        end
      end

      describe '#self.order_by_publish_date' do
        it 'should order by published' do
          Post.should_receive(:order).with('published_at DESC, created_at DESC, id DESC')
          Post.order_by_publish_date
        end
      end

      describe '#self.published' do
        it 'should only find Published Posts' do
          Post.should_receive(:where).with(state: 'published')
          Post.published
        end
      end

      describe '#self.published_and_ordered' do
        it 'should find published posts and order them by published date (FILO)' do
          Post.should_receive(:published).and_return Post
          Post.should_receive(:order_by_publish_date).and_return Post
          Post.should_receive(:includes).with(:author)
          Post.published_and_ordered
        end
      end

      describe '#self.scoped_for' do
        let(:user) { mock_model User, is_publisher?: true }

        context 'user is publisher' do
          it 'should see all the Posts' do
            Post.scoped_for(user).should == Post.scoped
          end
        end

        context 'user is not publisher' do
          before { user.should_receive(:is_publisher?).and_return false }

          it 'should see my own Posts only' do
            user.should_receive(:authored_posts)
            Post.scoped_for(user)
          end
        end
      end
    end

    describe "#allowed_to_update_permalink?" do
      context "post is published" do
        before do
          subject.state = 'published'
        end

        it "returns false" do
          subject.allowed_to_update_permalink?.should be_false
        end
      end

      context "post is not published" do
        before do
          subject.state = 'draft'
        end

        it "returns true" do
          subject.allowed_to_update_permalink?.should be_true
        end
      end
    end

    describe "#day" do
      context "published at in february" do
        before do
          subject.published_at = stub(:day => 2)
        end

        it "returns 02" do
          subject.day.should == "02"
        end
      end
    end

    describe "#formatted_published_date" do
      it "Formats the published_at date" do
        subject.published_at = Time.zone.parse('2012/02/18')
        subject.formatted_published_date.should == 'Feb 18, 2012'
      end
    end

    describe '#html_body' do
      before { subject.should_receive(:body).and_return '**w00t**' }

      it 'should parse the Markdown in the body' do
        subject.html_body.should =~ /<strong>w00t<\/strong>/
      end
    end

    describe '#legacy' do
      let(:string) { '2012-12-29-This_is_a_test' }
      before do
        subject.should_receive(:published_at=).with('2012-12-29')
        User.should_receive(:find_by_email).and_return 'FOO'
        subject.should_receive(:author=).with('FOO')
        subject.should_receive(:save)
        subject.should_receive(:publish)
        subject.should_receive(:update_attribute).with(:permalink, 'This_is_a_test')
      end

      it 'should update a Post from legacy URL' do
        subject.legacy(string, 'foo@bar.com')
      end
    end

    describe "#month" do
      context "published at in february" do
        before do
          subject.published_at = stub(:month => 2)
        end

        it "returns 02" do
          subject.month.should == "02"
        end
      end
    end

    describe "#publish_if_allowed" do
      let(:user) { Crowdblog::User.new }
      context "user is publisher" do
        before do
          user.is_publisher = true
        end

        it "changes its state" do
          subject.should_receive('publish')
          subject.publish_if_allowed('publish', user)
        end

        it "sets the user as publisher" do
          subject.publish_if_allowed('publish', user)
          subject.publisher.should be(user)
        end
      end

      context "user is not publisher" do
        before do
          user.is_publisher = false
        end

        it "does not change its state" do
          subject.should_not_receive('publish')
          subject.publish_if_allowed('publish', user)
        end
      end
    end

    describe "#regenerate_permalink" do
      it "generates the permalink based on the post title" do
        subject.title = 'A big long post title'
        subject.regenerate_permalink
        subject.permalink.should == 'a-big-long-post-title'
      end
    end

    describe '#url_params' do
      before { subject.stub(year: 'YEAR', month: 'MONTH',
                            day: 'DAY', permalink: 'PERMALINK') }

      it 'should return the array for permalink (year/month/day/permalink)' do
        subject.url_params.should == %w(YEAR MONTH DAY PERMALINK html)
      end
    end

  end
end
