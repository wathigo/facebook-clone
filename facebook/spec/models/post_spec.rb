require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post1) { FactoryBot.build(:post) }
  let(:luna) { FactoryBot.build(:user) }

  describe "General Post attributes validations" do
    it "should be valid" do
      post1.creator = luna
      expect(post1.errors.full_messages).to eql([])
      assert post1.valid?
    end

    it "title should be present" do
      post1.creator = luna
      post1.title = ''
      assert !post1.valid?
      post1.title = "MyText"
      assert post1.valid?
    end

    it "Content should be present" do
      post1.creator = luna
      post1.content = ''
      assert !post1.valid?
      post1.content = "This is some text"
      assert post1.valid?
    end
  end
end
