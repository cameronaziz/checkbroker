class AddAutoUpdatedToMutualFunds < ActiveRecord::Migration
  def change
    add_column :mutual_funds, :auto_updated, :datetime
  end
end
