class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :attendance, null: false, foreign_key: true
      t.references :attendance_to_change, foreign_key: { to_table: :attendances }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.text :content, null: false
    end
  end
end
