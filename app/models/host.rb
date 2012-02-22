class Host < ActiveRecord::Base
  belongs_to :user
  has_many :backups
  
  validates :name, :presence => true
  validates :user_id, :presence => true

  attr_accessible :name, :description, :created_at, :updated_at
end
