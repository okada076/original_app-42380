FactoryBot.define do
  factory :tag do
    name { "タグ#{SecureRandom.hex(4)}" }
  end
end
