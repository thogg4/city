class CreatePageRenders
  @queue = :pages_queue
  def self.perform(site_id)
    site = Site.find(site_id)
    site.pages.each do |page|
      page.create_render
    end
  end
end
