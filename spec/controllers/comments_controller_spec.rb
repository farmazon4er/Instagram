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

  describe '#create' do
    let(:params) do
      {
        user_id: user.id,
        post_id: post.id,
        comment: attributes_for(:comment)
      }
    end

    subject { get :create, params: params }

    it 'create comment' do
      expect { subject }.to change { Comment.count }.by(1)
      is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post)))
    end

    context 'when params invalid' do
      let(:params) do
        { user_id: user.id, post_id: post.id, comment: { comment_text: nil } }
      end

      it { is_expected.to render_template :new }
      it { expect { subject}.not_to change { Comment.count } }
    end

  end

  describe '#destroy' do
    let!(:comment) { create(:comment, user: user, post: post) }
    let(:params) { { user_id: user.id, post_id: post.id, id: comment.id } }
    subject { process :destroy, method: :delete, params: params }

    it 'destroy record' do
      expect { subject }.to change { Comment.count }.by(-1)
    end

    it { is_expected.to redirect_to(user_post_comments_path(assigns(:user), assigns(:post))) }
  end

end