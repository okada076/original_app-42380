FactoryBot.define do
  factory :step_progress do
    association :user
    association :growing_step
    checked { false }
  end
end
