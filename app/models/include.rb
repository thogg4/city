class Include < ActiveRecord::Base
  attr_accessible :body, :title, :site_id

  # callbacks
  before_save :save_pages

  # relationships
  belongs_to :site



  private

  def save_pages
    site = Site.find(self.site_id)
    site.pages.each do |page|
      page.save
    end
  end
end
