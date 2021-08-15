# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post }
  let(:params) { {user_id: user.id, post_id: post.id } }

  before { sign_in user }

  describe '#create' do

    subject { get :create, params: params }

    it 'create like' do
      expect { subject }.to change { Like.count }.by(1)
      is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post)))
    end
  end

  describe '#destroy' do
    let!(:like) { create(:like, user: user, post: post) }
    let(:params) { { user_id: user.id, post_id: post.id, id: like.id } }
    subject { process :destroy, method: :delete, params: params }

    it 'destroy record' do
      expect { subject }.to change { Like.count }.by(-1)
    end

    it { is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post))) }
  end
end