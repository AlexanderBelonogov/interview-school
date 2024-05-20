class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :teacher_subject, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.integer    :start_at, null: false
      t.integer    :end_at, null: false
      t.string     :week_days, null: false
      t.integer    :duration, null: false

      t.timestamps
    end
  end
end
