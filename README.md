# reserve - caching library based around Redis EXPIRE

This gem provides simple object caching support using Redis.

It works around the concept of "faulting"; you request an object from the
cache and if it already exists it will return the cached object. If not, it'll
execute the associated block to generate it instead.

Using Redis' `EXPIRE` functionality, the cached object can be set to
automatically disappear after a set period of time.

## Installation

Add this line to your application's Gemfile:

    gem 'reserve'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reserve

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

Copyright (c) 2014 Nick Charlton <nick@nickcharlton.net>
