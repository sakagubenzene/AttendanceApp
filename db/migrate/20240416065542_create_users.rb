class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :employee_number, null: false
      t.string :name, null: false
      t.string :password_digest, null: false
      t.boolean :admin, null: false, default: false
      t.string :remember_digest
      t.timestamps
    end
  end
end
