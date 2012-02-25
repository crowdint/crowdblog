Fabricator :post, class_name: 'Crowdblog::Post' do
  title                 { sequence { |i| "Random Post title #{i}" } }
  body                  { Faker::Lorem.words(rand(10) + 1) }
  state                 'drafted'
  author(fabricator: :user)
end

Fabricator :post_test, from: :post do
  title                 'This is a Test Post'
  body                  'A great post about how Crowd Interactive ROCKS!'
  author(fabricator: :user_test)
end

Fabricator :post_published, from: :post do
  title                 'This is a Published Post'
  body                  'Published Post! *yeeei*'
  state                 'published'
  published_at          { 1.minute.ago }
  publisher(fabricator: :user_publisher)
  permalink             { |post| post.title.parameterize }
end
