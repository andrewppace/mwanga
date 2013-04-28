class CreateProfilesEmailsJoinTable < ActiveRecord::Migration
  def change
    create_table :profiles_emails, :id => false do |t|
      t.integer :profile_id
      t.integer :email_id
    end
  end
end
