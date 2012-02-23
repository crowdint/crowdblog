class PostSweeper < ActionController::Caching::Sweeper
  observe CrowdblogCore::Post

  # Implement it in your base app!
end
