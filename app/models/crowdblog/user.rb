module  Crowdblog
  class User < ActiveRecord::Base
    include Gravtastic

    has_many :authored_posts, inverse_of: :author, foreign_key: 'author_id', class_name: 'Post'
    has_many :published_posts, inverse_of: :author, foreign_key: 'author_id', class_name: 'Post', conditions: ['state = ?', 'published'], order: 'published_at DESC'
    has_one  :last_post, class_name: 'Post', foreign_key: :author_id, conditions: ['state = ?', 'published'], order: 'published_at DESC, created_at DESC, id DESC'

    gravtastic :gravatar_email
    devise :database_authenticatable, :token_authenticatable, :trackable

    validate :email, uniqueness: true

    attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :is_publisher

    # INSTANCE METHODS
    def gravatar_email
      gravatar_alias || email
    end

    def last_post_at
      last_post.try(:published_at)
    end

    def last_published_at
      published_posts.first ? published_posts.first.published_at : nil
    end

    def publisher!
      update_attribute(:is_publisher, true)
    end

    def to_param
      [email.split('@').first]
    end
  end
end

