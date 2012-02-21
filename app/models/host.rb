class Host < ActiveRecord::Base
  has_many :backups
  
  validates :name, :presence => true
end
