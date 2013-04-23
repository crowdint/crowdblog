module Crowdblog
  module Query
    class UserQuery
      def initialize(scope = Crowdblog.user_class_name)
        @scope = scope
      end

      def authored_posts(author = current_user)
        Crowdblog::Post.where(author_id: author.id)
      end

      def published_posts(author = current_user)
        Crowdblog::Post.where(author_id: author.id, state: 'published').order('published_at DESC')     
      end

      def last_post(author = current_user)
        Crowdblog::Post.where(author_id: author.id, state: 'published').order('published_at DESC, created_at DESC, id DESC').first
      end

      def is_publisher?
        true
      end

      def last_post_at
        last_post.try(:published_at)
      end

      def last_published_at
        published_posts.first ? published_posts.first.published_at : nil
      end

    end
  end
end