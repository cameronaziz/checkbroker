class AddAddressToBroker < ActiveRecord::Migration
  def change
    add_column :brokers, :address1, :string
    add_column :brokers, :address2, :string
    add_column :brokers, :city, :string
    add_column :brokers, :state, :string
    add_column :brokers, :zip, :string
  end
end
