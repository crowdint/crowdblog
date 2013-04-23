module  Crowdblog
  class Post < ActiveRecord::Base
    belongs_to :author, :class_name => Crowdblog.user_class.name 
    belongs_to :publisher, :class_name => Crowdblog.user_class.name
    has_many :assets

    delegate :name, to: :author, prefix: true, allow_nil: true
    delegate :email, to: :author, prefix: true, allow_nil: true
    delegate :gravatar_url, to: :author

    delegate :year, to: :published_at

    attr_accessor :transition

    LEGACY_TITLE_REGEXP = /(\d+-\d+-\d+)-(.*)/

    state_machine initial: :drafted do
      state :drafted
      state :finished
      state :reviewed
      state :published

      event :finish do
        transition drafted: :finished
      end

      event :draft do
        transition finished: :drafted
      end
    end

    state_machine :publisher, attribute: :state, initial: :drafted, namespace: :as_publisher do
      state :drafted
      state :finished
      state :reviewed
      state :published

      before_transition on: :publish do |post, transition|
        post.published_at ||= Time.now
      end

      before_transition on: :draft do |post, transition|
        post.published_at = nil
      end

      event :draft do
        transition published: :drafted
      end

      event :finish do
        transition drafted: :finished
      end

      event :review do
        transition finished: :reviewed
      end

      event :publish do
        transition all => :published
      end
    end

    # CLASS METHODS
    class << self
      def all_posts_json
        includes(:author).
            order_by_publish_date.to_json only: [:id, :title, :state, :published_at, :ready_for_review],
                                      methods: [:author_email, :published?]
      end

      def by_author(author_id)
        published_and_ordered.where(author_id: author_id)
      end

      def last_published(number)
        published_and_ordered.limit(number)
      end

      def order_by_publish_date
        order('published_at DESC, created_at DESC, id DESC')
      end

      def published
        where(state: 'published')
      end

      def published_and_ordered
        published.order_by_publish_date
      end

      def scoped_for(user)
        user.is_publisher? ? all : user.authored_posts
      end

      def for_admin_index
        ordered_by_state.order_by_publish_date
      end

      def ordered_by_state
        order(:state)
      end
    end

    # Must be after Class methods (otherwise a missing method error will raise)
    scope :for_index,   ->  { last_published(3) }
    scope :for_history, ->  { last_published(13) }
    scope :all_for_feed, -> { last_published(15) }


    # INSTANCE METHODS
    def allowed_to_update_permalink?
      !self.published?
    end

    def day
      "%02d" % published_at.day
    end

    def formatted_published_date
      published_at.strftime("%b %d, %Y")
    end

    def html_body
      @@renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                             :autolink => true, :space_after_headers => true)
      @@renderer.render(self.body).html_safe
    end

    def legacy(string, email)
      string =~ LEGACY_TITLE_REGEXP
      self.published_at = $1
      user = User.find_by_email(email) || User.create!(email: email)
      self.author = user
      self.save
      self.publish
      self.update_attribute(:permalink, $2)
    end

    def month
      "%02d" % published_at.month
    end

    def publish_if_allowed(transition, user)
      if user.is_publisher?
        self.publisher = user
        self.send(transition)
      end
    end

    def regenerate_permalink
      self.permalink = title.parameterize
    end

    #
    # Use this methods to generate the post url
    # always use with the splat
    # operator
    #
    # Example:
    #   post_url(*post.url_params)
    #
    def url_params
      [self.year, self.month, self.day, self.permalink, 'html']
    end
  end
end
