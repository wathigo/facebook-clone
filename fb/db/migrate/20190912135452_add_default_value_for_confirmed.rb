# frozen_string_literal: true

class AddDefaultValueForConfirmed < ActiveRecord::Migration[5.2]
  def up
    change_column :friendships, :confirmed, :boolean, default: false
  end
end
