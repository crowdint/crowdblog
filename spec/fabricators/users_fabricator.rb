Fabricator :user, class_name: 'Crowdblog::User' do
  email                 { sequence { |i| "user#{i}@crowdint.com" } }
  name                  { Faker::Name.name }
  is_publisher          false
end

Fabricator :user_test, from: :user do
  email                 'test@crowdint.com'
  name                  'Test User'
  is_publisher          false
  authentication_token  'user'
end

Fabricator :user_publisher, from: :user do
  email                 'publisher@crowdint.com'
  name                  'Publisher User'
  is_publisher          true
  authentication_token  'publisher'
end
