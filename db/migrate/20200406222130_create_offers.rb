class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :advertiser_name, null: false, index: { unique: true }
      t.string :url, null: false
      t.text :description, null: false, limit: 500
      t.date :starts_at, null: false
      t.date :ends_at, null: true
      t.boolean :premium, null: true

      t.timestamps
    end
  end
end
