class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string  :name
      t.integer :value, null: false
      t.integer :category_id
      t.string  :date, null: false
      t.timestamps
    end
  end
end

