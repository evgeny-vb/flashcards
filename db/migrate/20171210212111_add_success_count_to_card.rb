class AddSuccessCountToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :success_count, :integer, null: false, default: 0
    add_column :cards, :fail_count, :integer, null: false, default: 0
  end
end
