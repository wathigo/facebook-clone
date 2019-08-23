require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  fixtures :users
  valid_emails = ['sampmle@yahoo.org', 'vin@example.com', 'shem@yahoo.ke', 'luna@example.com']
  invalid_emails = ['vim.com', 'hello@hiiscom', 'samplegmailcom']

  it "should be valid" do
    michael = users(:michael)
    assert michael.valid?
  end

  it "name should be present" do
    luna = users(:luna)
    luna.user_name = ''
    assert !luna.valid?
    luna.user_name = "Luna"
    assert luna.valid?
  end

  it "Email should be present" do
    archer = users(:archer)
    archer.email = ''
    assert !archer.valid?
    archer.email = "archer.@example.com"
    assert archer.valid?
  end

  it "Email format should be valid" do
    archer = users(:archer)
    valid_emails.each do |email|
      archer.email = email
      assert archer.valid?
    end
    invalid_emails.each do |email|
      archer.email = email
      assert !archer.valid?
      expect(archer.errors.full_messages[0]).to eql("Email is invalid")
    end
  end
end
