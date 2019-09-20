# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship1) { FactoryBot.create(:friendship) }
  let(:luna) { FactoryBot.create(:user) }

  describe 'General friendship attributes validations' do
    it 'should be valid' do
      expect(friendship1.errors.full_messages).to eql([])
      assert friendship1.valid?
    end

    it 'User should be present' do
      friendship1.user_id = ''
      assert !friendship1.valid?
      friendship1.user_id = luna.id
      assert friendship1.valid?
    end

    it 'Friend should be present' do
      friendship1.friend_id = ''
      assert !friendship1.valid?
      friendship1.friend_id = luna.id
      assert friendship1.valid?
    end
  end
end
