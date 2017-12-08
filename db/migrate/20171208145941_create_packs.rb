class CreatePacks < ActiveRecord::Migration[5.1]
  def change
    create_table :packs do |t|
      t.string :name
      t.belongs_to :user, foreign_key: true
      t.boolean :current, null: false, default: false

      t.timestamps
    end
  end
end
