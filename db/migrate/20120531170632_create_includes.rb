class CreateIncludes < ActiveRecord::Migration
  def change
    create_table :includes do |t|
      t.integer :site_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
