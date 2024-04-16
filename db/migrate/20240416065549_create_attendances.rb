class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :begin_at
      t.datetime :finish_at

      t.timestamps
    end
  end
end
