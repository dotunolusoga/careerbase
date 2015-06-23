class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
