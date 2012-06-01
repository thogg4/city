class Include < ActiveRecord::Base
  attr_accessible :body, :title, :site_id

  # callbacks
  after_save :save_pages_and_layouts

  # relationships
  belongs_to :site


  private

  def save_pages_and_layouts
    site = Site.find(self.site_id)
    site.pages.each do |page|
      page.save
    end
    site.layouts.each do |layout|
      layout.save
    end
  end

end
