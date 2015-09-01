class AddAboutToBroker < ActiveRecord::Migration
  def change
    add_column :brokers, :about, :text
  end
end
