class CreateAdViews < ActiveRecord::Migration
  def change
    create_table :ad_views do |t|

      t.belongs_to :brokerage
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
