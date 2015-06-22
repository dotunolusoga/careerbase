class AddEmploymentStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :employment_status, :string
  end
end
