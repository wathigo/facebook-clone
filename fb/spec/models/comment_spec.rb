# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:luna) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post, creator_id: luna.id) }
  let(:comment1) { FactoryBot.build(:comment, user_id: luna.id, post_id: post1.id) }

  describe 'General Comment attributes validations' do
    it 'should be valid' do
      expect(comment1.errors.full_messages).to eql([])
      assert comment1.valid?
    end

    it 'Content should be present' do
      comment1.content = ''
      assert !comment1.valid?
      comment1.content = 'This is some text'
      assert comment1.valid?
    end
  end
end
