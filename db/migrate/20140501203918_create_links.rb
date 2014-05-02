class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string  :title, null: false
      t.string  :url, null: false
      t.text    :text
      t.integer :sub_id, null: false

      t.timestamps
    end

    add_index :links, :sub_id
  end
end
