class AddCurrentPackToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :current_pack_id, :bigint
    User.all.each do |user|
      pack = user.packs.where(current: true).first
      user.update_column(:current_pack_id, pack.id) if pack
    end
    remove_column :packs, :current
  end

  def down
    add_column :packs, :current, :boolean
    User.where('current_pack_id IS NOT NULL').each do |user|
      pack = Pack.where(id: user.current_pack_id).first
      pack&.update_column(:current, true)
    end
    remove_column :users, :current_pack_id, :bigint
  end
end
