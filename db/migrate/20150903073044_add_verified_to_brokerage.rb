class AddVerifiedToBrokerage < ActiveRecord::Migration
  def change
    add_column :brokerages, :is_verified, :boolean
  end
end
