module Crowdblog
  class User < ActiveRecord::Base
    has_many :authored_posts, inverse_of: :author,
        foreign_key: 'author_id', class_name: 'Post'
    has_many :published_posts, -> {
          where(state: 'published').
          order('published_at DESC')
        },
        inverse_of: :author,
        foreign_key: 'author_id', class_name: 'Post'
    has_one  :last_post, -> {
          where(state: 'published').
          order('published_at DESC, created_at DESC, id DESC')
        },
        class_name: 'Post',
        foreign_key: :author_id

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
