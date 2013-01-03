class CreateInstagramPops < ActiveRecord::Migration
  def change
    create_table :instagram_pops do |t|
      t.string :username
      t.text :caption
      t.integer :comments_count
      t.integer :likes_count
      t.string :link
      t.string :low_resolution_url
      t.string :standard_resolution_url

      t.timestamps
    end
  end
end
