class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.integer :number, null: false

      t.timestamps
    end
    add_index :classrooms, :number, unique: true
  end
end
