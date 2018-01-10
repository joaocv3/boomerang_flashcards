class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.references :subject, foreign_key: true
      t.string :front
      t.string :back
      t.integer :memorizing_level

      t.timestamps
    end
  end
end
