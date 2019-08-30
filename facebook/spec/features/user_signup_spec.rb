require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  let(:michael) { FactoryBot.build(:user) }

  scenario 'user successfully signs up' do
    visit root_path
    click_link 'Sign up'
    expect do
      fill_in 'User name', with: michael.user_name
      fill_in 'Email', with: michael.email
      fill_in 'Password', with: michael.password
      fill_in 'Password confirmation', with: michael.password
      click_button 'Sign up'
    end.to change(User, :count).by(1)
  end
end
