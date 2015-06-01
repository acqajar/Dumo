class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :pin_id
      t.string :image

      t.timestamps null: false
    end
  end
end
