require 'dotenv'
Dotenv.load

require 'bundler/setup'
Bundler.setup

require 'status_cake'
require 'vcr'

ENV["RAILS_ENV"] ||= 'test'

# set in .env
ENV['STATUSCAKE_USER']    ||= 'FAKEUSER'
ENV['STATUSCAKE_APIKEY']  ||= 'APIKEY'
ENV['STATUSCAKE_VERBOSE'] ||= 'true'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.filter_sensitive_data('<APIKEY>') { ENV['STATUSCAKE_APIKEY'] }
  c.filter_sensitive_data('<USER>')   { ENV['STATUSCAKE_USER'] }
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run_excluding :disabled => true
end
