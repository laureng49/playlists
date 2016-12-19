class User < ActiveRecord::Base
  has_secure_password
  has_many :others
  has_many :songs, through: :others

  validates :first_name, :last_name, :email, :password, :presence => true, :on => :register
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, :uniqueness => true, :format => { :with => EMAIL_REGEX }


end
