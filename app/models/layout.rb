class Layout < ActiveRecord::Base
  attr_accessible :body, :title

  # relationships
  belongs_to :site
  has_many :pages
end
