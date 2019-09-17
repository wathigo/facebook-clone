# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:michael) { FactoryBot.create(:user) }
  let(:luna) { FactoryBot.create(:user) }
  let(:friendship1) { FactoryBot.create(:friendship) }

  describe '#create' do
    before do
      sign_in michael
    end

    it 'Increments michael(current_user) friendships by one' do
      expect { post :create, params: { id: luna.id } }.to change(michael.friendships, :count).by(1)
    end

    it 'Increments luna(friend) inverse_friendships by one' do
      expect { post :create, params: { id: luna.id } }.to change(luna.inverse_friendships, :count).by(1)
    end
  end

  describe '#update' do
    before do
      sign_in michael
      post :create, params: { id: luna.id }
      sign_out michael
    end

    it "Adds luna to Michael's friends list" do
      sign_in luna
      post :update, params: { id: michael.id }
      expect(michael.friends.include? luna).to eql(true)
    end

    it "Adds Michael to Luna's friends list" do
      sign_in luna
      post :update, params: { id: michael.id }
      expect(luna.friends.include? michael).to eql(true)
    end
  end

  describe '#destroy' do
    before do
      sign_in michael
      friendship1.user_id = luna.id
      friendship1.friend_id = michael.id
      friendship1.save
    end

    context 'When friendship_id is passed as a parameter' do
      it 'Deletes a friendship record entry' do
        expect { delete :destroy, params: { friendship_id: friendship1.id } }.to change(Friendship.all, :count).by(-1)
      end

      it 'Redirects to root path when there are no pending requests' do
        delete :destroy, params: { friendship_id: friendship1.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'When a user_id is passed as a parameter' do
      before do
        sign_out michael
        sign_in luna
      end

      it 'Deletes a friendship record entry' do
        expect { delete :destroy, params: { id: michael.id } }.to change(Friendship.all, :count).by(-1)
      end

      it 'Redirects to root path when there are no pending requests' do
        delete :destroy, params: { id: michael.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
