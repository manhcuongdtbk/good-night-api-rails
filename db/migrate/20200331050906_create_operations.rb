class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.datetime :operated_at, null: false

      t.timestamps
    end
  end
end
