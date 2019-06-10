# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_job/cron/version'

Gem::Specification.new do |spec|
  spec.name          = "active_job-cron"
  spec.version       = ActiveJob::Cron::VERSION
  spec.authors       = ["Stan Lo"]
  spec.email         = ["a22301613@yahoo.com.tw"]

  spec.summary       = %q{It provides functionality for actibe_jobs being triggered recurrently.}
  spec.description   = %q{It provides functionality for actibe_jobs being triggered recurrently.}
  spec.homepage      = "https://github.com/st0012/ActiveJob-Cron"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "celluloid"
  spec.add_dependency "ice_cube"
  spec.add_dependency "rails", "~> 5.2"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
