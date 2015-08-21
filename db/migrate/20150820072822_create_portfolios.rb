class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.belongs_to  :user
      t.float :management_fee
      t.timestamps null: false
    end
  end
end
