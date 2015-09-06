class RemoveNamesFromBrokerage < ActiveRecord::Migration
  def change
    remove_column :brokerages, :first_name
    remove_column :brokerages, :last_name
  end
end
