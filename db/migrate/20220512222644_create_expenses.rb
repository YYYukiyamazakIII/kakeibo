class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string  :name,        null: false
      t.integer :value,       null: false
      t.integer :category_id, null: false
      t.string  :date,        null: false
      t.references :user,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
