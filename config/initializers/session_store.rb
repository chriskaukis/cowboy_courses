# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cowboy_session',
  :secret      => '78e916ed3cdbf14c615a52c815b34b4410add7e81631b34a86b72c4cebadb9f3e70a8c09b9b883c1e1d2b0b5327e87e1c750c3ac1f37570567a99c3d9f441911'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
