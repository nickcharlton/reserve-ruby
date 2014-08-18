require 'json'

module Reserve
  class Store
    def initialize(redis)
      @redis = redis
    end

    def keep(key, expiry, &block)
      item = @redis.get key
      if item
        item = JSON.parse item
      else
        item = block.call

        @redis.pipelined do
          @redis.set key, item.to_json
          @redis.expire item, expiry
        end
      end

      item
    end
  end
end
