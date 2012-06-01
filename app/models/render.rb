class Render < ActiveRecord::Base
  attr_accessible :render, :page_id

  # relationships
  belongs_to :renderable, :polymorphic => true

end
