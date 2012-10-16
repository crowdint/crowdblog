module Crowdblog
  class User < ActiveRecord::Base
    has_many :authored_posts, inverse_of: :author,
        foreign_key: 'author_id', class_name: 'Post'
    has_many :published_posts, inverse_of: :author,
        foreign_key: 'author_id', class_name: 'Post',
        conditions: ['state = ?', 'published'], order: 'published_at DESC'
    has_one  :last_post, class_name: 'Post',
        foreign_key: :author_id, conditions: ['state = ?', 'published'],
        order: 'published_at DESC, created_at DESC, id DESC'

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
