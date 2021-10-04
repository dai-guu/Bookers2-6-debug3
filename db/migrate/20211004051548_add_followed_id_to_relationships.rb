class AddFollowedIdToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :followed_id, :integer


     create_table :relationships do |t|
       t.integer :follower_id
       t.integer :followed_id

      t.timestamps
    end


  end
end
