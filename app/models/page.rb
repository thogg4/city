class Page < ActiveRecord::Base

  attr_accessible :title, :path, :body, :site_id, :layout_id, :redis_hash

  # callbacks
  before_save :generate_redis_hash
  after_save :create_render

  # relationships
  belongs_to :site
  belongs_to :layout
  has_many :renders, :as => :renderable




  def generate_redis_hash
    self.redis_hash = rand(36**10).to_s(36)
  end

  def create_render
    page = self.dup
    page = page.parse_includes
    page = page.parse_article_includes
    $redis.set(self.redis_hash, page.body)
  end

  def parse_article_includes
    site = Site.find(self.site_id)
    article_includes = []
    articles = []
    page_body = ""
    self.body.match(/{{\s*article\s*\w*\s*}}/) { |m| article_includes << m }
    if article_includes.length > 0
      article_includes.each do |a|
        tag = a.to_s.scan(/\w+/)[1]
        site.articles.each do |article|
          article.tags.split(",").each do |t|
            if t.strip == tag
              articles << [a.to_s, article.title]
            end
          end
        end
      end
      articles.each do |a|
        self.body = a[1] ? self.body.sub(a[0], a[1]) : self.body.sub(a[0], "")
      end
    end
    self
  end

  def parse_includes
    site = Site.find(self.site_id)
    matches = self.body.scan(/{{\s*include\s*[^{}]+\s*}}/)
    if matches.length > 0
      matches.each do |match|
        include_title = match.scan(/{{\s*include\s*(.*?)\s*}}/)[0][0].to_s
        include = Include.where(title: include_title, site_id: site.id).first
        self.body = include ? self.body.sub(match, include.body) : self.body.sub(match, "No include found for #{include_title}")
      end
    end
    self
  end

end
