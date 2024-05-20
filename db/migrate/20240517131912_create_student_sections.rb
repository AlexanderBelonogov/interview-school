class CreateStudentSections < ActiveRecord::Migration[6.0]
  def change
    create_table :student_sections do |t|
      t.references :section, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
    add_index :student_sections, [:section_id, :student_id], unique: true
  end
end
