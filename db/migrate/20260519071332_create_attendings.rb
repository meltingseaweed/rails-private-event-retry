class CreateAttendings < ActiveRecord::Migration[8.1]
  def change
    create_table :attendings do |t|
      t.references :attendee, null: false, foreign_key: { to_table: :users }, index: true
      t.references :attended_events, null: false, foreign_key: { to_table: :events }, index: true

      t.timestamps
    end
  end
end
