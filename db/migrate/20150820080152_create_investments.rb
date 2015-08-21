class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.string :ticker
      t.integer :quantity
      t.belongs_to :portfolio

      t.timestamps null: false
    end
  end
end
