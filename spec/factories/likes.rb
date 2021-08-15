# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :like do
    association :user
    association :post

    user_id { user.id }
    post_id { post.id }
  end
end