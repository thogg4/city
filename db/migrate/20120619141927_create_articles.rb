class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :summary
      t.text :body
      t.text :footer
      t.text :notes
      t.integer :article_status_id
      t.integer :site_id
      t.string :author
      t.string :tags
      t.string :permalink
      t.datetime :published_on

      t.timestamps
    end
  end
end
