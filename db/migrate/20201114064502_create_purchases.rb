class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references  :product,                         foreign_key: true
      t.string      :serial_number,                   index: true
      t.boolean     :is_paid,                         default: false
      t.integer     :price_cents,                     limit: 8, default: 0, null: false
      t.string      :price_currency,                  default: "USD", null: false

      t.string      :token,                           index: true
      t.integer     :gateway_id
      t.string      :gateway_customer_id,             index: true
      # Customer info
      t.string      :customer_email

      t.timestamps
    end
  end
end
