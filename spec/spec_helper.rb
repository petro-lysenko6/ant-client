$:.push File.expand_path("../lib", __FILE__)
require 'rspec'
require 'ostruct'
require 'ant-client'

RSpec.configure do |c|
  c.mock_with :rspec
end