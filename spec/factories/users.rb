require 'ffaker'

FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    bio { FFaker::Job.title }
    password { 'password' }
    password_confirmation { 'password' }
  end
end