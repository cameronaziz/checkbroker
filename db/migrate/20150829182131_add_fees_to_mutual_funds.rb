class AddFeesToMutualFunds < ActiveRecord::Migration
  def change
    add_column :mutual_funds, :load, :float
    add_column :mutual_funds, :twelve_b_1, :float
  end
end
