require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:follower_follows).with_foreign_key(:following_id).class_name('Follow') }
  it { is_expected.to have_many(:followers).through(:follower_follows).source(:follower) }

  it { is_expected.to have_many(:following_follows).with_foreign_key(:follower_id).class_name('Follow') }
  it { is_expected.to have_many(:followings).through(:following_follows).source(:following) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:bio) }

end
