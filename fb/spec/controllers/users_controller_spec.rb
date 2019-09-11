# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:michael) { FactoryBot.create(:user) }
  describe '#show' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

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

  describe '#index' do
    before do
      sign_in michael
    end

    it 'Successfully sends a get request to user#index route' do
      get :index
      expect(response.status).to eql(200)
    end

    it 'Renders user index page if user is signed in' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
