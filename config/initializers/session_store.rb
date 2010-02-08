# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tr_app_session',
  :secret      => '67f8a6d70c25f63e900f68bf921b4c89bb2101394d1a6590aa78dfd5bfb24b9d30ab1338d2ecf75728bd93b1607ee111650cc88e1744e3030bac8989616bc3d4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
