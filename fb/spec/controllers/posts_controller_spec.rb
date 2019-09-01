require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:michael) { FactoryBot.create(:user) }
  let(:luna) { FactoryBot.create(:user) }
  let(:post1) {FactoryBot.build(:post)}
  let!(:post2) { FactoryBot.create(:post, creator_id: michael.id) }
  describe "#new" do
    it "Does not render :new when user is not logged in" do
      get :new
      expect(response).to_not render_template(:new)
    end

    it "Renders :new when User is signed in" do
      sign_in michael
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    before do
      sign_in michael
    end

    it "Redirects to root path upon success" do
      post_params = FactoryBot.attributes_for(:post, user_id: michael.id)
      post :create, params: { post: post_params }
      expect(response).to redirect_to(root_path)
    end

    it "Icrements user's created posts by one" do
      post_params = FactoryBot.attributes_for(:post, user_id: michael.id)
      expect{ post :create, params: { post: post_params } }.to change(michael.created_posts, :count).by(1)
    end
  end

  describe "#index" do
    it "Renders template :index when a user is signed in" do
      sign_in michael
      get :index
      expect(response).to render_template(:index)
    end

    it "Redirects to sign_in page if a user is not signed in" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  describe "#destroy" do

    before do
      sign_in michael
    end

    it "Reduces user's created posts by one" do
      expect{ delete :destroy, params: { id: post2.id} }.to change(michael.created_posts, :count).by(-1)
    end

    it "Does not delete if logged in user is not the creator of the post" do
      sign_in luna
      expect{ delete :destroy, params: { id: post2.id} }.to change(michael.created_posts, :count).by(0)
    end
  end
end
