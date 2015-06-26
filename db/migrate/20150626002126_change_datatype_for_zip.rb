class ChangeDatatypeForZip < ActiveRecord::Migration

  def self.up
    change_table :companies do |t|
      t.change :zip, :string
    end
  end

  def self.down
    change_table :companies do |t|
      t.change :zip, :integer
    end
  end
  
end
