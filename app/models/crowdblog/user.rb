module  Crowdblog
  class User < ActiveRecord::Base
    self.table_name = :users
    include Gravtastic

    has_many :authored_posts, inverse_of: :author, foreign_key: 'author_id', class_name: 'Post'

    devise :database_authenticatable, :token_authenticatable

    gravtastic :gravatar_email

    def publisher!
      update_attribute(:is_publisher, true)
    end

    def gravatar_email
      (gravatar_alias || email)
    end

    def last_post_at
      authored_posts.published_and_ordered.first.try(:published_at)
    end
  end
end

