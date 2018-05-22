class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :read_status
      t.boolean :favorite, default: false

      t.timestamps
    end
  end
end
