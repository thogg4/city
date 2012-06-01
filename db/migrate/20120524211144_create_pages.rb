class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :path
      t.text :body
      t.integer :site_id
      t.integer :layout_id
      t.string :redis_hash

      t.timestamps
    end
  end
end
