class RenameSnippetNameToDescription < ActiveRecord::Migration
  def change
    rename_column :snippets, :name, :description
  end
end
