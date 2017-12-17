class AddEFactorToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :e_factor, :float, default: 1.3
    add_column :cards, :days_offset, :integer, default: 1
  end
end
