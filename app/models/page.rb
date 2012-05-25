class Page < ActiveRecord::Base

  attr_accessible :title, :path, :body, :layout_id

  # relationships
  belongs_to :site
  belongs_to :layout

end
