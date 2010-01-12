class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.text :description
      t.integer :account_id
      t.boolean :status
      t.datetime :remind_at
      t.boolean :self_remind
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
