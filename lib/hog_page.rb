module HogPage

  def self.parse_article_includes(page)
    site = Site.find(page.site_id)
    article_includes = []
    articles = []
    page_body = ""
    page.body.match(/{{\s*article\s*\w*\s*}}/) { |m| article_includes << m }
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
        page_body = page.body.sub(a[0], a[1])
      end
    else
      page_body = page.body
    end
    page_body
  end

  def self.parse_includes(page)
    site = Site.find(page.site_id)
    matches = page.body.scan(/{{\s*include\s*[^{}]+\s*}}/)
    if matches.length > 0
      matches.each do |match|
        include_title = match.scan(/{{\s*include\s*(.*?)\s*}}/)[0][0].to_s
        include = Include.where(title: include_title, site_id: site.id).first
        page_body = include ? page.body.sub(match, include.body) : page.body.sub(match, "No include found for #{include_title}")
      end
    else
      page_body = page.body
    end
    page_body
  end


end
