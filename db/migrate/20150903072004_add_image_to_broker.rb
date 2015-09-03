class AddImageToBroker < ActiveRecord::Migration
  def change
    add_column :brokerages, :image, :string
  end
end
