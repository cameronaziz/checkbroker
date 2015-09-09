class RemoveUserFromAdvisor < ActiveRecord::Migration
  def change
    remove_column :advisors, :user_id
    add_column :advisors, :has_advisor, :boolean
  end
end
