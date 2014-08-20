# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'Reserve Main Methods' do
  before do
    # use MockRedis if just testing, real redis if in CI
    if ENV['CI']
      @redis = Redis.new
    else
      @redis = MockRedis.new
    end

    @reserve = Reserve::Store.new(@redis)
  end

  it 'stores a simple object using a key' do
    item = @reserve.keep :item, 3600 do
      { value: "this is item" }
    end

    item.wont_be_nil
    item.must_be_kind_of Hash
    item.must_equal Hash[value: "this is item"]
  end

  it 'sets the timeout correctly on an object' do
    item = @reserve.keep :item, 3600 do
      { value: "this is item" }
    end

    item.wont_be_nil
    item_ttl = @redis.ttl(:item)
    item_ttl.must_equal 3600
  end
end
