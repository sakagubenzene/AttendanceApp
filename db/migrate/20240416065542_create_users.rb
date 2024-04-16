class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.boolean :admin
      t.string :employee_number

      t.timestamps
    end
  end
end
