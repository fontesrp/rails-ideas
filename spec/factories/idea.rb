FactoryBot.define do
  factory :idea, class: 'Idea' do
    title { Faker::ChuckNorris.fact }
    description { Faker::Lorem.paragraph }
  end
end
