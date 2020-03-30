class CreateSleeps < ActiveRecord::Migration[6.0]
  def change
    create_table :sleeps do |t|
      t.string :type, null: false
      t.datetime :started_at, null: false
      t.datetime :stopped_at
      t.float :duration
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
