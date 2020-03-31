class CreateSleeps < ActiveRecord::Migration[6.0]
  def change
    create_table :sleeps do |t|
      t.float :duration
      t.bigint :operation_start_id, null: false
      t.bigint :operation_stop_id
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_foreign_key :sleeps, :operations, column: :operation_start_id
    add_foreign_key :sleeps, :operations, column: :operation_stop_id
  end
end
