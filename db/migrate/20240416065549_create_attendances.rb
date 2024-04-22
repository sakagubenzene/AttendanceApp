class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :timestamp, null: false
      t.string :status, null: false
      t.text :reason
      t.timestamps
    end
  end
end
