class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :username, null: false
      t.text :first_name, null: false
      t.text :last_name, null: false

      t.timestamps
    end
    add_index :students, :username, unique: true
  end
end
