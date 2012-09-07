require 'spec_helper'

module Crowdblog
  describe User do

    describe '#gravatar_email' do
      context 'when using a Gravatar' do
        before { subject.should_receive(:gravatar_alias).and_return 'GRAVATAR' }

        it 'should use the alias' do
          subject.gravatar_email.should == 'GRAVATAR'
        end
      end

      context 'when not using a Gravatar' do
        before do
          subject.should_receive(:gravatar_alias)
          subject.should_receive(:email).and_return 'EMAIL'
        end

        it 'should use the email' do
          subject.gravatar_email.should == 'EMAIL'
        end
      end
    end

    describe '#last_post_at' do
      context 'when has posts' do
        let(:post) { mock_model Post }

        before do
          subject.should_receive(:last_post).and_return post
          post.should_receive(:published_at).and_return '2012-06-31'
        end

        it 'should be the published post date' do
          subject.last_post_at.should == '2012-06-31'
        end
      end

      context 'when no posts' do
        it 'should be nil' do
          subject.should_receive(:last_post)
          subject.last_post_at.should be_nil
        end
      end
    end

    describe "#last_published_at" do
      context 'has published posts' do
        let(:date) { Date.today }

        before do
          posts = [ mock_model(Post, :published_at => date), mock_model(Post, :published_at => 1.day.ago) ]
          subject.stub(:published_posts).and_return posts
        end

        it "returns the published_at date of the first post" do
          subject.last_published_at.should be(date)
        end
      end

      context 'no published posts' do
        before do
          subject.stub(:published_posts).and_return []
        end

        it "returns nil" do
          subject.last_published_at.should be_nil
        end
      end
    end

    describe '#publisher!' do
      it 'should make User a Publisher' do
        subject.should_receive(:update_attribute).with(:is_publisher, true)
        subject.publisher!
      end
    end

  end
end
