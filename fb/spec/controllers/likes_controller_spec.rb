# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:michael) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post, creator_id: michael.id) }
  let(:comment1) { FactoryBot.create(:comment, user_id: michael.id, post_id: post1.id) }

  describe '#create' do
    before do
      sign_in michael
    end

    context 'When liking a comment' do
      it 'Redirects to root path upon success' do
        post :create, params: { comment_id: comment1.id }
        expect(response).to redirect_to(root_path)
      end

      it 'increaments the comments likes by one' do
        expect { post :create, params: { comment_id: comment1.id } }.to change(comment1.likes, :count).by(1)
      end

      it 'increaments user likes by one' do
        expect { post :create, params: { comment_id: comment1.id } }.to change(michael.likes, :count).by(1)
      end

      it 'Decrements the likes a comment twice a user likes twice' do
        expect { post :create, params: { comment_id: comment1.id } }.to change(michael.likes, :count).by(1)
        expect { post :create, params: { comment_id: comment1.id } }.to change(michael.likes, :count).by(-1)
      end
    end
    context 'When liking a post' do
      it 'Redirects to root path upon success' do
        post :create, params: { post_id: post1.id }
        expect(response).to redirect_to(root_path)
      end

      it 'increaments the posts likes by one' do
        expect { post :create, params: { post_id: post1.id } }.to change(post1.likes, :count).by(1)
      end

      it 'increaments user likes by one' do
        expect { post :create, params: { post_id: post1.id } }.to change(michael.likes, :count).by(1)
      end

      it 'Decrements the likes a post twice a user likes twice' do
        expect { post :create, params: { post_id: post1.id } }.to change(michael.likes, :count).by(1)
        expect { post :create, params: { post_id: post1.id } }.to change(michael.likes, :count).by(-1)
      end
    end
  end
  describe '#destroy' do
    before do
      sign_in michael
      post :create, params: { post_id: post1.id }
      post :create, params: { comment_id: comment1.id }
    end
    context 'When disliking a comment' do
      it 'Decrements post likes by one' do
        expect { delete :destroy, params: { post_id: post1.id } }.to change(post1.likes, :count).by(-1)
      end

      it 'Decrements user likes by one' do
        expect { delete :destroy, params: { post_id: post1.id } }.to change(michael.likes, :count).by(-1)
      end
    end
    context 'When disliking a comment' do
      it 'Decrements coment likes by one' do
        expect { delete :destroy, params: { comment_id: comment1.id } }.to change(comment1.likes, :count).by(-1)
      end

      it 'Decrements user likes by one' do
        expect { delete :destroy, params: { comment_id: comment1.id } }.to change(michael.likes, :count).by(-1)
      end
    end
  end
end
