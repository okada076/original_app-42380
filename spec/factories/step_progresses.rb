FactoryBot.define do
  factory :step_progress do
    user { nil }
    growing_step { nil }
    checked { false }
  end
end
