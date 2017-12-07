class AddImageToCard < ActiveRecord::Migration[5.1]
  def up
    add_attachment :cards, :picture
  end

  def down
    remove_attachment :cards, :picture
  end
end
