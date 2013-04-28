class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_salt
      t.string :password_hash
      t.string :state
      t.string :email_state
      t.string :email_confirmation_salt
      t.timestamps
    end
  end
end

