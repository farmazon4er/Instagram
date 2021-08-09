require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to validate_presence_of(:comment_text) }
  it { is_expected.to validate_length_of(:comment_text).is_at_most(50) }
end
