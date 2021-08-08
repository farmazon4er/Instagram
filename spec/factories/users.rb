require ''

FactoryBot.define do
  factory :user do
    name { 'John' }
    bio  { 'Fireman' }
    email { 'email@email.ru' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end