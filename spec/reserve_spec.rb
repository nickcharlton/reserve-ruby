# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'Reserve Main Methods' do
  before do
    # use MockRedis if just testing, real redis if in CI or if USE_REDIS is set.
    if ENV['CI'] || ENV['USE_REDIS']
      @redis = Redis.new
    else
      @redis = MockRedis.new
    end

    @reserve = Reserve.new(@redis)
  end

  it 'stores a simple object using a key' do
    item = @reserve.store :item do
      { value: "this is item" }
    end

    item.wont_be_nil
    item.must_be_kind_of Hash
    item.must_equal({value: "this is item"})
  end

  it 'sets the (default) timeout correctly on an object' do
    item = @reserve.store :item do
      { value: "this is item" }
    end

    item.wont_be_nil
    item_ttl = @redis.ttl("reserve_#{:item.to_s}")
    item_ttl.must_equal 10800
  end

  it 'works with a custom timeout' do
    item = @reserve.store :item, timeout: 3600 do
      { value: "this is item" }
    end

    item.wont_be_nil
    item_ttl = @redis.ttl("reserve_#{:item.to_s}")
    item_ttl.must_equal 3600
  end

  it 'can skip the cache with an option' do
    standard_item = @reserve.store :item do
      { value: "this is item" }
    end

    standard_item.wont_be_nil

    clean_item = @reserve.store :item, skip_cache: true do
      { value: "this is a different item" }
    end

    clean_item.wont_be_nil

    standard_item.wont_equal clean_item
  end
end
