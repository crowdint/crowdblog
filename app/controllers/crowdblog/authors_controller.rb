module  Crowdblog
  class AuthorsController < Controller

    def index
      @authors = User.includes(:authored_posts).sort {|a,b| b.authored_posts.count <=> a.authored_posts.count}
    end

  end
end
