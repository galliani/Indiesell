class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string          :name
      t.text            :description
      t.integer         :price_cents, default: 0, null: false, limit: 8
      t.string          :price_currency, default: 'USD', null: false
      t.boolean         :is_live, default: false
      t.string          :serial_number

      t.timestamps
    end
  end
end
