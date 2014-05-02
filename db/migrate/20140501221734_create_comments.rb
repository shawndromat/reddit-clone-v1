class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text    :body, null: false
      t.integer :author_id, null: false
      t.integer :link_id, null: false
      t.integer :parent_comment_id

      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, :link_id
    add_index :comments, :parent_comment_id
  end
end
