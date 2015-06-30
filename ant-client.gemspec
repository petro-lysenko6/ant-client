# Encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'ant/version'

Gem::Specification.new do |s|
  s.name     = %q{ant-client}
  s.version  = Ant::VERSION
  s.platform = Gem::Platform::RUBY

  s.authors = ['Helios Technologies Ltd.']
  s.license = %q{MIT}
  s.summary     = %q{A Ruby client to use Ant.com API to manage Bookmarks.}
  s.description = %q{ A Ruby client to use Ant.com API to manage Bookmarks. Can easily parse pages and create indexed weblink.}
  s.email       = %q{contact@heliostech.fr}
  s.homepage    = 'http://rubygems.org/gems/ant-client'

  s.bindir        = 'bin'
  s.executables   = %w(ant)
  s.require_paths = %w(lib)
  s.files         = Dir['lib/**/*.rb']

  s.add_dependency 'bundler', '~> 1.0'
  s.add_dependency 'activesupport', '~> 3.2'
  s.add_dependency 'thor', '0.18.1'
  s.add_dependency 'httparty'
end
