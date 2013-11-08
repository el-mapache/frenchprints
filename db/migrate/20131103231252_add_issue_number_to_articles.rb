class AddIssueNumberToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :issue_number, :string
  end
end
