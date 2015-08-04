# This file is copied to spec/ when you run "rails generate rspec:install"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "capybara/rails"
require "vcr"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |c|
  c.cassette_library_dir = "fixtures/vcr_cassettes"
  c.hook_into :webmock # or :fakeweb
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
  c.allow_http_connections_when_no_cassette = true
  c.ignore_localhost = true
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.infer_spec_type_from_file_location!
end

Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
  "Statue of Liberty, NY, USA", [
    {
      "latitude"     => 40.6892494,
      "longitude"    => -74.0445003,
      "address"      => "Statue of Liberty National Monument, New York, NY, USA",
      "state"        => "New York",
      "state_code"   => "NY",
      "country"      => "United States",
      "country_code" => "US"
    }
  ]
)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      "latitude"     => 40.7143528,
      "longitude"    => -74.0059731,
      "address"      => "New York, NY, USA",
      "state"        => "New York",
      "state_code"   => "NY",
      "country"      => "United States",
      "country_code" => "US"
    }
  ]
)
