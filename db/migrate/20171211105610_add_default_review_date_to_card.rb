class AddDefaultReviewDateToCard < ActiveRecord::Migration[5.1]
  def up
    change_column :cards, :review_date, :datetime, null: false, default: -> { 'now()' }
  end

  def down
    change_column :cards, :review_date, :datetime, null: true
    change_column_default :cards, :review_date, nil
  end
end
