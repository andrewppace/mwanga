class CreateProfilesAddressesJoinTable < ActiveRecord::Migration
  def change
    create_table :profiles_addresses, :id => false do |t|
      t.integer :profile_id
      t.integer :address_id
    end
  end
end
