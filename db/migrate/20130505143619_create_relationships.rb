class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :invitor_id
      t.integer :invitee_id
      t.integer :profile_id
      t.string :state
      t.timestamps
    end
  end
end
