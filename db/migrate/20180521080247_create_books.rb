class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.datetime :publish_date
      t.float :price
      t.integer :number_of_pages
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
