class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :description
      t.references :user
      t.references :contact
      t.timestamps
    end
  end
end
