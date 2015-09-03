class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :broker
      t.belongs_to :user
      t.integer :rating
      t.text :comment
      t.timestamps null: false
    end
  end
end
