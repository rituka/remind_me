# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_remind_me_session',
  :secret      => '683f85270ba40f54b21d07f98717a38d25aacff388a36fa621885587610ffcd98800608ec2c86e478efdaa3eab714b8ad9d8f8af097a75e85c99aed1fb621d77'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
