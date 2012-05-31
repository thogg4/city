class Site < ActiveRecord::Base

  attr_accessible :title, :domain, :host
  # relationships
  belongs_to :package
  has_many :layouts
  has_many :pages
  has_many :includes


  def self.get_by_id(id)
    find(id)
  end

  def self.get(request)
    where(host: request.host.downcase).first
  end

end
