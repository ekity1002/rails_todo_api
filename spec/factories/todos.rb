FactoryBot.define do
  factory :todo do
    title { "MyString" }
    completed { false }
    description { "MyText" }
    due_date { "2024-01-21" }
  end
end
