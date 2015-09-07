class CreateOrganizationAdvisors < ActiveRecord::Migration
  def change
    create_table :organization_advisors do |t|
      t.belongs_to :organization
      t.belongs_to :advisor
      t.boolean :is_verified
      t.timestamps null: false
    end
  end
end
