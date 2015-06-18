class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.integer :zip
      t.string :description
      t.string :phone
      t.string :url
      t.string :email
      t.string :contact_name
      t.string :emp_count
      t.string :industry

      t.timestamps null: false
    end
  end
end
