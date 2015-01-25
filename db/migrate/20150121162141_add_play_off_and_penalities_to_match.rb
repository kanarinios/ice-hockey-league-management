class AddPlayOffAndPenalitiesToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :play_off, :boolean, default: false
    add_column :matches, :penalities, :boolean, default: false
  end
end
