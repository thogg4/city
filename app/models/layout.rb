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
    # first find and ludes
    includes = layout.scan(/{{\s*include\s*[^{}]+\s*}}/)
    if includes.length > 0
      includes.each do |i|
        include_title = i.scan(/(?!i)(?!n)(?!c)(?!l)(?!u)(?!d)(?!e)[a-z]+/)[0].to_s
        include = Include.where(title: include_title, site_id: self.site_id).first
        layout = include ? layout.sub(i, include.body) : layout.sub(i, "No include found for #{include_title}")
      end
    end

    layout = layout.sub("{{ css }}", "<link href='http://#{self.site.host}/assets/global.css' media='screen' rel='stylesheet' type='text/css'>")

    layout = layout.sub("{{ js }}", "<script src='http://#{self.site.host}/assets/global.js' type='text/javascript'></script>")

    $redis.set(self.redis_hash, layout)
  end

end
