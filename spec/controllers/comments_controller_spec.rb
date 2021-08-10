# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post }
  let(:params) { { user_id: user, post_id: post } }

  before { sign_in user }

  describe '#index' do
    subject { get :index, params: params }

    let!(:comment) { create :comment, user: user, post: post }

    it 'assign @comments' do
      subject
      expect(assigns(:comments)).to eq([comment])
    end

    it { is_expected.to render_template('index') }
  end

  describe '#new' do
    subject { get :new, params: params }

    context 'when user signed in' do
      before { sign_in user }

      it { is_expected.to render_template(:new) }

      it 'assigns new comment' do
        subject
        expect(assigns(:comment)).to be_a_new Comment
      end
    end
  end



end