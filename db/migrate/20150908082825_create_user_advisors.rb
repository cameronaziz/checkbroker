class CreateUserAdvisors < ActiveRecord::Migration
  def change
    create_table :user_advisors do |t|
      t.belongs_to :user
      t.belongs_to :advisor
      t.boolean :is_verified

      t.timestamps null: false
    end
  end
end
