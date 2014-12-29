class AddWinnerToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :winner, :integer
  end
end
