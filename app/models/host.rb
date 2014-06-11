class Host < ActiveRecord::Base
  belongs_to :user
  has_many :backups
  
  validates :name, :presence => true
  validates :user_id, :presence => true
end
