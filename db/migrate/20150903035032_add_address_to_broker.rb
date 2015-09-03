class AddAddressToBroker < ActiveRecord::Migration
  def change
    add_column :brokerages, :address1, :string
    add_column :brokerages, :address2, :string
    add_column :brokerages, :city, :string
    add_column :brokerages, :state, :string
    add_column :brokerages, :zip, :string
  end
end
