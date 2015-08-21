class CreateMutualFunds < ActiveRecord::Migration
  def change
    create_table :mutual_funds do |t|
      t.string :ticker
      t.float :nav
      t.float :expense_ratio

      t.timestamps null: false
    end
  end
end
