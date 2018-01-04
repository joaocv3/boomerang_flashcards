class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :front
      t.string :back
      t.integer :memorizing_level
      t.integer :subject_id

      t.timestamps
    end
  end
end
