class CreateTeaSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :tea_subscriptions do |t|
      t.references :tea, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
