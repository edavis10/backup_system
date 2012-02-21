class CreateBackups < ActiveRecord::Migration
  def change
    create_table :backups do |t|
      t.text :log
      t.integer :host_id

      t.timestamps
    end
  end
end
