class CreateFirstNames < ActiveRecord::Migration
  def change
    create_table :first_names do |t|
      t.references :contact
      t.string :name
      t.timestamps
    end
  end
end
