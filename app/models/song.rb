class Song < ActiveRecord::Base
  validates :title, :artist, length: {minimum: 2}
  has_many :others
  has_many :users, through: :others
  
end
