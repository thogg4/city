class Page < ActiveRecord::Base
  attr_accessible :title, :path, :body, :layout_id

  # callbacks
  before_save :create_render

  # relationships
  belongs_to :site
  belongs_to :layout
  has_many :renders




  private

  def create_render
    self.renders.first.destroy rescue nil
    page = self.body
    matches = page.scan(/{{\s*include\s*[^{}]+\s*}}/)
    if matches.length > 0
      matches.each do |match|
        include_title = match.scan(/(?!i)(?!n)(?!c)(?!l)(?!u)(?!d)(?!e)[a-z]+/)[0].to_s
        include = Include.where(title: include_title, site_id: self.layout.site_id).first
        page = include ? page.sub(match, include.body) : page.sub(match, "No include found")
      end
    end
    html = self.layout.body.sub("{{ page }}", page)
    self.renders.create(render: html)
  end

end
