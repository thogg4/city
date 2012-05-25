class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :layouts do |t|
      t.string :title
      t.text :body
      t.integer :site_id

      t.timestamps
    end
  end
end
