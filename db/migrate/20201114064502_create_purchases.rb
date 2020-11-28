class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.string    :serial_number,     index: true
      t.string    :token,             index: true
      t.boolean   :is_paid
      t.integer   :price_cents,       limit: 8, default: 0, null: false
      t.string    :price_currency,    default: "USD", null: false
      t.string    :customer_email,    index: true

      t.timestamps
    end
  end
end
