# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'Reserve Main Methods' do
  before do
    # use MockRedis if just testing, real redis if in CI
    if ENV['CI']
      redis = Redis.new
    else
      redis = MockRedis.new
    end

    @reserve = Reserve.new(redis)
  end
end
