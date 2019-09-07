# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:michael) { FactoryBot.build(:user) }
  let(:luna) { FactoryBot.build(:user) }
  valid_emails = ['sampmle@yahoo.org', 'vin@example.com', 'shem@yahoo.ke', 'luna@example.com']
  invalid_emails = ['vim.com', 'hello@hiiscom', 'samplegmailcom']

  describe 'General user attributes validations' do
    it 'should be valid' do
      assert michael.valid?
    end

    it 'name should be present' do
      luna.user_name = ''
      assert !luna.valid?
      luna.user_name = 'Luna'
      assert luna.valid?
    end

    it 'Email should be present' do
      michael.email = ''
      assert !michael.valid?
      michael.email = 'archer.@example.com'
      assert michael.valid?
    end

    it 'Email format should be valid' do
      valid_emails.each do |email|
        michael.email = email
        assert michael.valid?
      end
      invalid_emails.each do |email|
        michael.email = email
        assert !michael.valid?
        expect(michael.errors.full_messages[0]).to eql('Email is invalid')
      end
    end
    it 'Email should be downcase' do
      luna.email = 'LUNA@example.org'
      luna.save!
      expect(luna.email).to eql('luna@example.org')
    end
  end
  describe 'devise specific attributes validations' do
    it 'should include the encrypted_password attribute' do
      expect(luna.attributes).to include('encrypted_password')
    end

    it 'should include the reset_password_sent_at attribute' do
      expect(luna.attributes).to include('reset_password_sent_at')
    end

    it 'should include the reset_password_token attribute' do
      expect(luna.attributes).to include('reset_password_token')
    end

    it 'should include the remember_created_at attribute' do
      expect(luna.attributes).to include('remember_created_at')
    end
  end
end
