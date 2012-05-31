class CreateRenders < ActiveRecord::Migration
  def change
    create_table :renders do |t|
      t.integer :page_id
      t.text :render

      t.timestamps
    end
  end
end
