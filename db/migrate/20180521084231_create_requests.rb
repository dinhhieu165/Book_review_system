class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
