class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :ugly_path, null: false
      t.string :url, null: false
      t.string :url_md5, null: false
      t.string :title
      t.timestamps
    end

    add_index :links, :ugly_path, :unique => true
    add_index :links, :url_md5, :unique => true
  end
end
