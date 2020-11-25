class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.references  :purchase,        foreign_key: true
      t.text        :blob_signed_id
      t.text        :filename
      t.string      :content_type
      t.integer     :download_size,   limit: 8
      t.text        :url
      t.datetime    :expiry
      t.integer     :download_count,  default: 0

      t.timestamps
    end
  end
end
