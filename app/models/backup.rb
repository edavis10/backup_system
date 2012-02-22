class Backup < ActiveRecord::Base
  belongs_to :host
  
  validates :host_id, :presence => true

  def self.search(term)
    sql_term = "%" + term.downcase + "%"
    self.where("lower(log) LIKE (?)", sql_term)
  end
end
