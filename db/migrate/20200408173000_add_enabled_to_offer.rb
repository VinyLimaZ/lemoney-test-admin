class AddEnabledToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :enabled, :boolean, default: true
  end
end
