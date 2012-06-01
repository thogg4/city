class Layout < ActiveRecord::Base
  attr_accessible :body, :title

  # callbacks
  before_save :generate_redis_hash
  after_save :create_render

  # relationships
  belongs_to :site
  has_many :pages
  has_many :renders, :as => :renderable


  private
  def generate_redis_hash
    self.redis_hash = rand(36**11).to_s(36)
  end

  def create_render
    self.renders.first.destroy rescue nil
    layout = self.body
    matches = layout.scan(/{{\s*include\s*[^{}]+\s*}}/)
    if matches.length > 0
      matches.each do |match|
        include_title = match.scan(/(?!i)(?!n)(?!c)(?!l)(?!u)(?!d)(?!e)[a-z]+/)[0].to_s
        include = Include.where(title: include_title, site_id: self.site_id).first
        layout = include ? layout.sub(match, include.body) : layout.sub(match, "No include found for #{include_title}")
      end
    end
    $redis.set(self.redis_hash, layout)
  end

end
