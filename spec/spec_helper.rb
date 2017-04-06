# frozen_string_literal: true

require 'bundler/setup'
require 'observe_event'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require 'pathname'

def read(path)
  path = Pathname.new(__dir__).join('..').join(path).expand_path

  path.read
end
