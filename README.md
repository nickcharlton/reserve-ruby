# reserve - caching library based around Redis EXPIRE

[![Build Status](https://travis-ci.org/nickcharlton/reserve-ruby.svg?branch=master)](https://travis-ci.org/nickcharlton/reserve-ruby)
[![Coverage Status](https://img.shields.io/coveralls/nickcharlton/reserve-ruby.svg)](https://coveralls.io/r/nickcharlton/reserve-ruby)

This gem provides simple object caching support using Redis.

It works around the concept of "faulting"; you request an object from the
cache and if it already exists it will return the cached object. If not, it'll
execute the associated block to generate it instead.

Using Redis' `EXPIRE` functionality, the cached object can be set to
automatically disappear after a set period of time.

## Installation

Reserve isn't (yet) on [RubyGems][], so add the repo to your [Gemfile][]:

```ruby
gem 'reserve', :git => 'https://github.com/nickcharlton/reserve-ruby.git'
```

## Usage

```ruby
reserve = Reserve.new(Redis.new)

# store an item with a given key
item = reserve.store :item do
  { value: "this is item" }
end

item # => { value: "this is item" }
```

Both `Reserve.new` and `store` accept a hash of options, but they're a little
bit different for each:

For `Reserve.new`:

```ruby
default_timeout: 3600 # the default timeout to use with store.
key_prefix: 'reserve' # the prefix to use in Redis.
```

For `store`:

```ruby
timeout: 3600 # the timeout to use when storing this item.
skip_cache: true # skip the cache in this invokation (great for testing).
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

Copyright (c) 2014 Nick Charlton <nick@nickcharlton.net>

[RubyGems]: http://rubygems.org
[Gemfile]: http://bundler.io
