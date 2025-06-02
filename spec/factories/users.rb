FactoryBot.define do
  factory :user do
    nickname { 'テストユーザー' }
    email { 'test@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
