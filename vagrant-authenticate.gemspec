# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
puts "Load path"
puts $LOAD_PATH
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-authenticate/version'

Gem::Specification.new do |spec|
  spec.name    = 'vagrant-authenticate'
  spec.version = VagrantPlugins::Authenticate::VERSION
  spec.authors = [
    'TA Guys'
  ]
  spec.email = [
    'joel@testautomation.com'
  ]
  spec.description = %q{A Vagrant plugin to authenticate user to artifactory }
  spec.summary     = spec.description
  spec.homepage    = 'https://www.vagrant.com'
  spec.license     = 'Apache 2.0'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.2.0'

  spec.post_install_message = <<-EOH
The Vagrant Authenticate plugin
EOH

  spec.add_development_dependency 'spork', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rake'
end
