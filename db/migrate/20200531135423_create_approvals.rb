class CreateApprovals < ActiveRecord::Migration[5.1]
  def change
    create_table :approvals do |t|
      t.date :month
      t.string :decision
      t.string :authorizer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
