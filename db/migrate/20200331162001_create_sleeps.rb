class CreateSleeps < ActiveRecord::Migration[6.0]
  def change
    create_table :sleeps do |t|
      t.datetime :clock_in, precision: 6, null: false
      t.datetime :clock_in_created_at, precision: 6, null: false
      t.datetime :clock_out, precision: 6
      t.datetime :clock_out_create_at, precision: 6
      t.float :duration
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
