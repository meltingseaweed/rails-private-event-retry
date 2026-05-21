class CreateInvitations < ActiveRecord::Migration[8.1]
  def change
    create_table :invitations do |t|
      t.references :invited_users, null: false, foreign_key: { to_table: :users }, index: true
      t.references :invited_events, null: false, foreign_key: { to_table: :events }, index: true

      t.timestamps
    end
  end
end
