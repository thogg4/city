class Article < ActiveRecord::Base

  attr_accessible :article_status_id, :author, :body, :footer, :notes, :permalink, :published_on, :summary, :tags, :title

  # callbacks
  after_save :create_page_renders

  # relationships
  belongs_to :site


  def create_page_renders
    site = Site.find(self.site_id)
    Resque.enqueue(CreatePageRenders, site.id)
  end

end
