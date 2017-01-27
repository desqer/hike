class AddEmailFieldsToLists < ActiveRecord::Migration[5.0]
  def change
    remove_column :lists, :email_template # reorder collumn

    add_column :lists, :email_from, :string
    add_column :lists, :email_subject, :string
    add_column :lists, :email_template, :text
  end
end
