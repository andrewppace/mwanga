class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :contact
      t.string :address
      t.string :description
      t.timestamps
    end
  end
end
