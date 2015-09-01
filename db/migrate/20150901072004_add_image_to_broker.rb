class AddImageToBroker < ActiveRecord::Migration
  def change
    add_column :brokers, :image, :string
  end
end
