require 'bundler/setup'
require 'az_clearance_card_verifier'
require 'az_clearance_card_verifier/card'
require 'az_clearance_card_verifier/card_builder'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
