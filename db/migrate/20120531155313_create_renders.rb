class CreateRenders < ActiveRecord::Migration
  def change
    create_table :renders do |t|
      t.integer :renderable_id
      t.string :renderable_type
      t.text :render

      t.timestamps
    end
  end
end
