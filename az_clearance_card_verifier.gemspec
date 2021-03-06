# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'az_clearance_card_verifier/version'

DESCRIPTION = 'This gem acts as an inteface between a Ruby application ' \
 'and the AZ Department of Public Safety website in order to verify the ' \
 'status of fingerprint clearance cards, given a card number.'.freeze

Gem::Specification.new do |spec|
  spec.name          = 'az_clearance_card_verifier'
  spec.version       = AzClearanceCardVerifier::VERSION
  spec.authors       = ['Jayson Virissimo']
  spec.email         = ['jayson.virissimo@asu.edu']

  spec.summary       = 'Verify the status of a fingerprint clearance card'
  spec.description   = DESCRIPTION
  spec.homepage      = 'https://github.com/jaysonvirissimo/az_clearance_card_verifier'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'httparty', '~> 0.15'
  spec.add_development_dependency 'nokogiri', '~> 1.8'
end
