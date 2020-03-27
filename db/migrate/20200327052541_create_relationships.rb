class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.bigint :follower_id, null: false
      t.bigint :followed_id, null: false
      t.index [:follower_id, :followed_id], unique: true

      t.timestamps
    end

    add_foreign_key :relationships, :users, column: :follower_id, on_delete: :cascade
    add_foreign_key :relationships, :users, column: :followed_id, on_delete: :cascade
  end
end
