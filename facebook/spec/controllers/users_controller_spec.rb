require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#show' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
    let(:michael) { FactoryBot.create(:user) }

    it 'It should not render :show when user in not logged in' do
      get :show, params: { id: michael.id }
      expect(response).to_not render_template(:show)
    end

    it 'Renders :show when a user is logged in' do
      sign_in michael
      get :show, params: { id: michael.id }
      expect(response).to render_template(:show)
    end
  end
end
