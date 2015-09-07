class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|
      t.belongs_to :user
      t.string :first_name
      t.string :last_name
      t.string :image
      t.string :phone, limit: 10
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip, limit: 5
      t.boolean :is_verified
      t.timestamps null: false
    end
  end
end
