class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :organization
      t.string :website
      t.string :bio
      t.references :user

      t.timestamps
    end
  end
end
