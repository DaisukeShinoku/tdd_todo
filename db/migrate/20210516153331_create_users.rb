class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :short_name, null: false
      t.string :display_name, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
