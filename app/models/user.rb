class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password

  # relationships
  has_many :sites

  # authentication
  has_secure_password
  validates_presence_of :email, :on => :create
  validates_presence_of :password, :on => :create

end
