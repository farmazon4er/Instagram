require 'ffaker'

FactoryBot.define do
  factory :comment do
    association :user, :post

    comment_text { FFaker::Lorem.sentence }
  end

end