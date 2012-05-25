class Page < ActiveRecord::Base

  attr_accessible :title, :path, :body
  belongs_to :site

end
