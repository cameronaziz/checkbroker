class AddNameToBrokerage < ActiveRecord::Migration
  def change
    add_column :brokerages, :name, :string
  end
end
