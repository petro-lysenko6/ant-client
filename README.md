ant-client gem is gem to access Ant.com open API

install: gem install ant-client
in Gemfile: gem 'ant-client', :require => 'ant_client'

it also includes useful HMAC module that can generates and verify security tokens

1. module Ant::HMAC can be mixed in another class or used as separate module with methods

Ant::HMAC.generate_secret
  # generates random token secret 32 symbols length
Ant::HMAC.hmac secret, {id: 1, ts: Time.now.to_i}
  # generates SHA1 token that can be verified later
  # requires mandatory id and ts parameters
Ant::HMAC.verify? object, {id: 1, ts: timestamp, token: token}
  # verifies token that was generated before
  # requires object that should respond to api_key method which returns secret
  # id, ts, token that were generated before
  # returns object if tokens are equal

2. Ant cmd line is cmd tool to manage Bookmarks for Ant.com
   now it can create show Weblink and Library

  # to show help and usage type
  ant
  ant --help

  # create show weblink
  ant weblink create 1 izwkXcOeiyn4yWBCnnyaSmMUGvxp5h35 google.com --server localhost:3000
  ant weblink show 1 izwkXcOeiyn4yWBCnnyaSmMUGvxp5h36 80 --server localhost:3000

  # create show library
  ant library create 1 izwkXcOeiyn4yWBCnnyaSmMUGvxp5h36 cmd_lib hello --server localhost:3000
  ant library show 1 izwkXcOeiyn4yWBCnnyaSmMUGvxp5h36 1 --server localhost:3000


==========

  TODO:
    1. pending tests and tests for Ant::Client, Ant::Command
    2. add comments and generate documentation for Ant::Client and cmd
    3. add more restfool actions
    4. refactor code

Ant.com ruby client