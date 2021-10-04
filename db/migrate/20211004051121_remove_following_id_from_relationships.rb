class RemoveFollowingIdFromRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :following_id, :integer
  end
end
