class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :contact
      t.string :pobox
      t.string :extended
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :label
      t.timestamps
    end
  end
end
