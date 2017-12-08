class AddPackToCard < ActiveRecord::Migration[5.1]
  def up
    add_reference :cards, :pack, foreign_key: true

    ActiveRecord::Base.transaction do
      User.all.each do |user|
        pack = Pack.create!(user: user, name: 'Основная колода')
        user.cards.update_all(pack_id: pack.id)
      end
    end

    remove_reference :cards, :user
  end

  def down
    add_reference :cards, :user, foreign_key: true

    Pack.all.each do |pack|
      user = pack.user
      pack.cards.update_all(user_id: user.id)
    end

    remove_reference :cards, :pack
  end
end
