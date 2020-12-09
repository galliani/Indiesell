class EnableFreeDownloadForProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products,   :is_free,       :boolean, default: false
    add_column :purchases,  :is_free,       :boolean, default: false
    add_column :purchases,  :has_been_sent, :boolean, default: false
  end
end
