class AddPickedColumnToPeriodTable < ActiveRecord::Migration
  def change
  	add_column :periods, :picked, :boolean
  end
end
