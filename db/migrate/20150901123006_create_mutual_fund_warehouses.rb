class CreateMutualFundWarehouses < ActiveRecord::Migration
  def change
    create_table :mutual_fund_warehouses do |t|
      t.string :ticker
      t.string :name
      t.string :objective
      t.float :twelve_b_1
      t.float :back_load
      t.float :front_load
      t.float :expense_ratio

      t.timestamps null: false
    end
  end
end
