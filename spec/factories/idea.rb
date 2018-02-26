FactoryBot.define do
  factory :idea, class: 'Idea' do
    association :user, factory: :user
    title { Faker::ChuckNorris.fact }
    description { Faker::Lorem.paragraph }
  end
end
