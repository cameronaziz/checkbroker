class AddNicknameToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :nickname, :string
  end
end
