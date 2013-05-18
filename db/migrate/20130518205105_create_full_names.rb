class CreateFullNames < ActiveRecord::Migration
  def change
    create_table :full_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
