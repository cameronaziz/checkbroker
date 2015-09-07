class CreateOrganizationAdmins < ActiveRecord::Migration
  def change
    create_table :organization_admins do |t|
      t.belongs_to :organization
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
