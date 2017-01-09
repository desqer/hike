class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.references :lead, type: :uuid, foreign_key: true
      t.references :list, type: :uuid, foreign_key: true
      t.string :status, index: true

      t.timestamps
    end
  end
end
