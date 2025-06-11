FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "発芽しました#{n}-#{SecureRandom.hex(2)}" }
    content { '順調に育っています' }
    category { :grow_log }

    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png') }

    association :vegetable
    association :user
  end
end
