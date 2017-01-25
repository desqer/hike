class AddEmailTemplateToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :email_template, :text
  end
end
