class Page < ActiveRecord::Base
  attr_accessible :title, :path, :body, :site_id, :layout_id, :redis_hash

  # callbacks
  before_save :generate_redis_hash
  after_save :create_render

  # relationships
  belongs_to :site
  belongs_to :layout
  has_many :renders, :as => :renderable




  private
  def generate_redis_hash
    self.redis_hash = rand(36**10).to_s(36)
  end

  def create_render
    self.renders.first.destroy rescue nil
    page = self.body
    matches = page.scan(/{{\s*include\s*[^{}]+\s*}}/)
    if matches.length > 0
      matches.each do |match|
        include_title = match.scan(/(?!i)(?!n)(?!c)(?!l)(?!u)(?!d)(?!e)[a-z]+/)[0].to_s
        include = Include.where(title: include_title, site_id: self.site_id).first
        page = include ? page.sub(match, include.body) : page.sub(match, "No include found for #{include_title}")
      end
    end
    $redis.set(self.redis_hash, page)
  end

end
