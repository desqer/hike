class AddAttachmentToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :attachment, :string
  end
end
