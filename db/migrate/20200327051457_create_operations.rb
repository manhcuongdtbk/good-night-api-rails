class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.integer :operation_type, null: false
      t.datetime :operated_at, null: false
      t.references :sleep, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
