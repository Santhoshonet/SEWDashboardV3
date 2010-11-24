# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SEWDashboardV5_session',
  :secret      => '0c05ef6b13bff066c7a66e7f90ded42dc47733121e97b7e0b6d5d03ca325cdb59107577b6708b7ebb578634a9d3a05e3ace44aeafc28b8efa3469b8ed3fddacf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
