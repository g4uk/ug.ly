class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.references :link
      t.string :source
      t.string :domain
      t.cidr :remote_ip
      t.string :country
      t.string :state
      t.string :city
      t.boolean :direct
      t.string :browser_name
      t.string :browser_version
      t.boolean :bot
      t.string :device_name
      t.string :os
      t.timestamps
    end
  end
end
