class AddSubmitterIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :submitter_id, :integer
  end
end
