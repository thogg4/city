class Render < ActiveRecord::Base
  attr_accessible :render, :page_id

  # relationships
  belongs_to :page
end
