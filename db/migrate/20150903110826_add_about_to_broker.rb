class AddAboutToBroker < ActiveRecord::Migration
  def change
    add_column :brokerages, :about, :text
  end
end
