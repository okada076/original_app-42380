FactoryBot.define do
  factory :growing_step do
    title { 'MyString' }
    content { 'MyText' }
    step_number { 1 }
    vegetable { nil }
  end
end
