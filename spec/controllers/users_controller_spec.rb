# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }
  let(:params)  { { id: user.id } }
  before { sign_in user }

  describe '#index' do
    subject { get :index, params: params}
    it { is_expected.to render_template('index') }
  end

  describe '#show' do
    subject { get :show, params: params }
    it { is_expected.to render_template(:show) }
  end

  describe '#edit' do
    subject { get :edit, params: params }

    it { is_expected.to render_template(:edit) }

    it 'assigns server policy' do
      subject
      expect(assigns :user).to eq user
    end
  end

  describe '#update' do
    let(:params) { { id: user.id, user: { name: 'Ivan Ivanov' } } }

    subject { put :update, params: params }

    it { is_expected.to redirect_to(user_path(assigns(:user))) }

    it 'updates user' do
      expect { subject }.to change { user.reload.name }.to('Ivan Ivanov')
    end

    context 'with bad params' do
      let(:params) { { id: user.id, user: { name: ''} } }
      it 'does not update user' do
        expect { subject }.not_to change { user.reload.name }

      end
    end
  end

end