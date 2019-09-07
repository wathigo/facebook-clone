# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:michael) { FactoryBot.create(:user) }
  let(:luna) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post, creator_id: michael.id) }
  let(:comment1) { FactoryBot.create(:comment, user_id: michael.id, post_id: post1.id) }
  let(:comment2) { FactoryBot.build(:comment, user_id: michael.id) }

  describe '#create' do
    before do
      sign_in michael
    end

    it 'Redirects to root path upon success' do
      post :create, params: { comment: { content: comment1.content, post_id: post1.id } }
      expect(response).to redirect_to(root_path)
    end

    it "Icrements user's created comments by one" do
      comment_params = FactoryBot.attributes_for(:comment, post_id: post1.id)
      expect { post :create, params: { comment: comment_params } }.to change(michael.comments, :count).by(1)
    end
  end
  describe '#destroy' do
    it "Reduces user's created comments by one" do
      sign_in michael
      comment2.post_id = post1.id
      comment2.save
      expect { delete :destroy, params: { format: comment2.id } }.to change(post1.comments, :count).by(-1)
    end
  end
end
