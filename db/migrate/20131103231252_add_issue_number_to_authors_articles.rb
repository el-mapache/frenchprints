class AddIssueNumberToAuthorsArticles < ActiveRecord::Migration
  def change
    add_column :authors_articles, :issue_number, :string
  end
end
