FactoryBot.define do
  factory :vegetable do
   name { "野菜#{SecureRandom.hex(4)}" }
  end
end
