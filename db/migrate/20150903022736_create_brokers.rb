class CreateBrokers < ActiveRecord::Migration
  def change
    create_table :brokers do |t|
      t.belongs_to :user
      t.belongs_to :brokerage

      t.timestamps null: false
    end
  end
end
