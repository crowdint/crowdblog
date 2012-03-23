module  Crowdblog
  class User < ActiveRecord::Base
    self.table_name = :users
    include Gravtastic

    has_many :authored_posts, inverse_of: :author, foreign_key: 'author_id', class_name: 'Post'
    has_one  :last_post, class_name: 'Post', foreign_key: :author_id, conditions: ['state = ?', 'published'], order: 'published_at DESC, created_at DESC, id DESC'

    gravtastic :gravatar_email


    # INSTANCE METHODS
    def gravatar_email
      gravatar_alias || email
    end

    def last_post_at
      last_post.try(:published_at)
    end

    def publisher!
      update_attribute(:is_publisher, true)
    end

    def to_param
      [email.split('@').first]
    end
  end
end

