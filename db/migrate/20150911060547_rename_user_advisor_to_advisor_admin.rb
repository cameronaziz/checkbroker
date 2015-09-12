class RenameUserAdvisorToAdvisorAdmin < ActiveRecord::Migration
  def change
    rename_table :user_advisors, :advisor_admins
  end
end
