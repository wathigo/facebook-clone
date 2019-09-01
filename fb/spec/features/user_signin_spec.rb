require 'rails_helper'

RSpec.feature "UserSignins", type: :feature do
  let(:michael) { FactoryBot.create(:user) }

  scenario 'user successfully logs in' do
    visit root_url
    expect(current_url).to eql(new_user_session_url)
    fill_in 'Email', with: michael.email
    fill_in 'Password', with: michael.password
    click_button 'Log in'
    expect(current_url).to eql(root_url)
  end
end
