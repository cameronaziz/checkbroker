class OrgColumnsChange < ActiveRecord::Migration
  def change
    add_column :organization_admins, :is_verified, :boolean
    rename_table :user_advisors, :advisor_admins
  end
end
