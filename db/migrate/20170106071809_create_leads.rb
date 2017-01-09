class CreateLeads < ActiveRecord::Migration[5.0]
  def change
    create_table :leads, id: :uuid do |t|
      t.string :name
      t.string :email, index: { unique: true }

      t.timestamps
    end
  end
end
