class InitialMigration < ActiveRecord::Migration
  def self.up
    create_table "accounts", :force => true do |t|
      t.string   "facebook_uid"
      t.boolean  "active"
      t.boolean  "is_app_user"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "sessions", :force => true do |t|
      t.string   "session_id", :null => false
      t.text     "data"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    execute("ALTER TABLE accounts CHANGE facebook_uid facebook_uid BIGINT") if adapter_name.to_s == "MySQL"
    add_index "accounts", ["facebook_uid"], :name => "index_accounts_on_facebook_uid"
    
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"
    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  end
  
  def self.down
    drop_table :accounts
    drop_table :sessions
  end
end
