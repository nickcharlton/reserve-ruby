# test coverage
require 'coveralls'

# enable coveralls
Coveralls.wear!

# test framework
require 'minitest/autorun'
require 'minitest/pride'
require 'redis'
require 'mock_redis'

# pull in the library
require File.expand_path '../lib/reserve.rb', __dir__
