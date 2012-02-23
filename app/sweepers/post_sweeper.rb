class PostSweeper < ActionController::Caching::Sweeper
  observe Crowdblog::Post

  # Implement it in your base app!
end
