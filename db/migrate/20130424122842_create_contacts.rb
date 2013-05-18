class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
  end
end
