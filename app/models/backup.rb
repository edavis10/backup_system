class Backup < ActiveRecord::Base
  belongs_to :host
  
  validates :host_id, :presence => true
end
