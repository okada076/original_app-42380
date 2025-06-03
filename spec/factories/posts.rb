FactoryBot.define do
  factory :post do
    title { '発芽しました' }
    content { '順調に育っています' }
    category { :grow_log } # enumのキー

    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png') }

    association :vegetable
    association :user
  end
end
