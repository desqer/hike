class ChangeIndexLeadListOnSubscriptions < ActiveRecord::Migration[5.0]
  def change
    remove_index :subscriptions, :lead_id
    remove_index :subscriptions, :list_id

    add_index :subscriptions, [:lead_id, :list_id], unique: true
  end
end
