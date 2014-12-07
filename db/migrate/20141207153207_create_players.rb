class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.float :weight
      t.float :height
      t.string :country

      t.timestamps
    end
  end
end
