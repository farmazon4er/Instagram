# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let!(:current_user){ create :user }
  before { sign_in current_user }

  describe '#create' do
    let!(:following_user) { create :user }
    let(:params) { { following_id: following_user.id } }
    subject { post :create, params: params }

    it 'create following' do
      expect { subject }.to change { Follow.count }.by(1)
      is_expected.to redirect_to(user_followings_path(assigns(:current_user)))
      expect { subject }.to change { Follow.count }.by(0)  # check double follow
    end
  end

  describe '#destroy' do
    let!(:following_user) { create :user }
    let(:params) { { following_id: following_user.id } }

    before { post :create, params: params }

    subject { delete :destroy, params: params }

    it 'destroy follow' do
      expect { subject }.to change { Follow.count }.by(-1)
    end

    it { is_expected.to redirect_to(user_followings_path(assigns(:user))) }
  end

end